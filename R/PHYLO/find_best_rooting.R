tMRCA <- function(lm){-coef(lm)[1]/coef(lm)[2]} ## Get  X-intercept from regression
#################
RDV <- function(tree) diag(vcv.phylo(tree)) ## Extract root-to-tip divergences 
#################
get.ages <- function(tree)  as.numeric(unlist(lapply(strsplit(tree$tip.label, "_"), function(x) x[3])))
#################
reroot.p <- function(tree, node.number, proportion){ ## re-roots the tree at a node, splitting the branch at a particular 'proportion'
  if(node.number>length(tree$tip)){## Thanks to Liam Revell (UMass) for the code snippet
    tr <- root(tree, node = node.number, resolve.root = TRUE)
    b <- sum(tr$edge.length[tr$edge == (Ntip(tree) + 1)])
    position <- proportion*b
    tr$edge.length[tr$edge == (Ntip(tree) + 1)] <- c(position, b-position)
  } else {
    tr1 <- root(tree, node = tree$edge[match(node.number, tree$edge[, 2]), 1])
    tr1 <- drop.tip(tr1, tree$tip.label[node.number])
    b <- tree$edge.length[match(node.number, tree$edge[, 2])]
    position <- proportion*b
    tr2 <- list(edge = matrix(c(3L, 1L, 3L ,2L), 2, 2, byrow = TRUE),
                tip.label = c(tree$tip.label[node.number], "NA"),
                edge.length = c(tree$edge.length[match(node.number, tree$edge[, 2])]-position, position), Nnode = 1)
    class(tr2) <- "phylo"
    tr <- bind.tree(tr2, tr1, where = which(tr2$tip.label == "NA"))
    tr <- reorder.phylo(x = tr, order = "postorder")
  }
  return(tr)
}
#################
opt.p.branch <- function(p, inode, tr, loss = "residuals"){ # takes a proportion and a node number and returns the objective function value 
  temp.tree <- reroot.p(tr, node.number = inode, proportion = p)
  temp.tree <- reorder.phylo(x = temp.tree, order = "postorder")
  dates <- get.ages(tree = temp.tree)
  temp.rdvs <- RDV(temp.tree)
  reg <- lm(temp.rdvs~dates)
  if(coef(reg)[2]<0 || is.na(coef(reg)[2])){
    return(Inf)
  }else{
    # begin loss function test
    if(loss == "residuals"){
      return(sum(reg$residuals^2))
    } else{
      if(loss == "Rsquared"){
        return(-summary(reg)$r.squared)
      }else{
        if(loss == "correlation"){
          return(-cor(temp.rdvs, dates))
        }else{
          break("Please specify loss function")
        }
      }
    }# end loss function test   
  } 
}
#################
give.alpha <- function(vd, vt, cs, m, bounded = TRUE){ 
  ## the analytical solution. Takes a vector of divergences (vd), a vector of times (vt), the children indicators (cs) and the branch length m
  N <- length(vd)
  n <- sum(cs)
  d.bar <- mean(vd)
  t.bar <- mean(vt)
  C <- sum(vt^2) - (sum(vt)^2)/N
  Ai <- 2*cs - (2*n-N)/N + 2*(t.bar-vt)/(C*N)*(N*sum(vt*cs) - n*sum(vt))-1
  Bi <- vd-d.bar + (t.bar-vt)/(C*N)*(N*sum(vt*vd)- sum(vt)*sum(vd))
  alpha <- -sum(Ai*Bi)/(m*sum(Ai^2))
  if(bounded){# failsafe to ensure \alpha \in (0, 1)
    alpha <- min(max(alpha, 0), 1) 
    if(n == N | n == 0){alpha <- 0}  
  }  
  return(alpha)
}
#################
#################
get.alpha <- function(tr, node, loss = "residuals"){ ## Extracts the necessary components from the tree and applies give.alpha().  
  ## For now relies on a horrendous hack to get the indicators, for lack of intelligence of its creator... ;0)
  Tree <- reorder.phylo(x = tr, order = "postorder")
  base.tree <- reroot.p(tree = Tree, node = node, p = 0)
  shift.tree <- reroot.p(tree = Tree, node.number = node, p = .5)
  rdvs <- RDV(base.tree)
  diffs <- as.numeric(RDV(shift.tree)-rdvs)
  inds <-  ifelse(diffs>0, 1, 0) ## who "will" be added 
  blength <- 2*abs(diffs[[1]])  
  times <- get.ages(base.tree)
  a <- give.alpha(vd = rdvs, vt = times, cs = inds, m = blength, bounded = TRUE)
  return(list(alpha = a,
              loss = opt.p.branch(p = a,
                                  inode = node, tr = Tree, loss = loss)))
}
#################
find_best_rooting <- function(tree, heuristics = FALSE, loss = "residuals", Optim = FALSE, debug = FALSE){ ## Main function that wraps that up
  #### Begin documentation ########
  # tree = a phylogenetic tree with well formatted tip.labels.
  # WARNING: PLEASE modify the function get.ages() to ensure it works for your tip labels!
  # Note: by default, it expects labels to be separated by a '_'  and the date to be the THIRD field.
  # heuristics = try only old branches/nodes? Potentially speeds up things.
  # what kind of 'loss' to use? Options are mean squared 'residuals', 'correlation' or 'Rsquared'.
  # 'Optim': use numerical optimisation? Defaults to FALSE and uses an analytical solution instead.
  #### End documentation ##########
  cat("Date range:", range(get.ages(tree)), "\n")
  tree <- unroot(tree)
  tree <- multi2di(tree, random = TRUE)
  tree <- reorder.phylo(x = tree, order = "postorder")
  nodes <- setdiff(seq_len(Nedge(tree)), Ntip(tree) + 1)
  if(Optim){
    best.ps <- lapply(nodes,
                      function(j){
                        if(debug) cat("Doing node", j, "\n")
                        return(optimise(opt.p.branch, c(0, 1), tol = 1E-8, inode = j, tr = tree, loss = loss))
                      }
    ) 
    node.p <- unlist(lapply(best.ps, function(x) x$minimum))
    loss.nodes <- unlist(lapply(best.ps, function(x) x$objective))
  }else{
    best.ps <- lapply(nodes,
                      function(j){
                       if(debug) cat("Doing node", j, "\n")
                        return(get.alpha(tr = tree, node = j))
                      }
    ) 
    node.p <- unlist(lapply(best.ps, function(x) x$alpha))
    loss.nodes <- unlist(lapply(best.ps, function(x) x$loss))
  }
  min.nodes <- min(loss.nodes) 
  cand.nodes <- nodes[which(loss.nodes == min.nodes)]
  cand.ps <- node.p[which(loss.nodes == min.nodes)]
  result.tree <- reroot.p(tree, node = max(cand.nodes),  proportion = node.p[match(max(cand.nodes), nodes)])
  rdv <- RDV(result.tree)
  ages <- get.ages(result.tree)
  result.reg <- lm(rdv~ages) 
  if(debug){
    return(
      list(minObj = min.nodes,
           possibleNodes = cand.nodes,
           losses = loss.nodes,
           proportions = cand.ps,
           best.root.node = max(cand.nodes), lm = result.reg, tree = result.tree,
           proportion = node.p[match(max(cand.nodes), nodes)],
           table = data.frame(rdv = rdv, dates = ages, residuals = result.reg$residuals))
    )  
  }else{
    return(
      list(best.root.node = max(cand.nodes), lm = result.reg, tree = result.tree,
           proportion = node.p[match(max(cand.nodes), nodes)],
           table = data.frame(rdv = rdv,
                              dates = ages,
                              residuals = result.reg$residuals))
    )  
  }
} 
