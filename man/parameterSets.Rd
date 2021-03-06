\name{parameterSets}
\alias{parameterSets}
\title{ Generate parameter sets }
\description{
  Generate parameter sets from given ranges, with chosen sampling
  scheme.
}
\usage{
parameterSets(par.ranges, samples,
    method = c("latin.hypercube", "random", "all.combinations"))
}
\arguments{
  \item{par.ranges}{ A named list of (numeric) parameter values. Each
    element can be:
    \itemize{
      \item a single number, for fixed parameters;
      \item a length-2 vector, representing a range of values;
      \item a vector of length > 2, representing a fixed set of
      values. Also, a length 2 vector can be defined as a fixed set of
      values by wrapping it in \code{I()}. Such fixed sets of
      values are resampled when \code{method = "latin.hypercube"} or
      \code{"random"}. 
    }
  }
  \item{samples}{ Number of samples to generate. In the
    \code{"all.combinations"} method, the result may not have exactly
    this length. }
  \item{method}{ the sampling scheme; see Details. }
}
\details{
  Method \code{"latin.hypercube"} generates a regular sequence for each
  free parameter range (using \code{\link{quantile}} and
  \code{\link{ppoints}}), and a repeated sequence for each fixed
  parameter set. Each of these sequences is then randomly permuted. For
  the special case of \code{samples = 1}, the mean of each range is
  returned.

  Method \code{"random"} generates uniform random values in each free
  parameter range, and random samples from each fixed parameter set.

  Method \code{"all.combinations"} generates a regular sequence for each
  free parameter range, and keeps each fixed parameter set as given. All
  combinations of these values are then calculated (using
  \code{expand.grid}). The length of the free parameter sequences is
  chosen such that the total number of results does not exceed
  \code{samples}. However, if fixed parameter sets are given, the
  number of combinations of these may exceed \code{samples}, and then
  any free parameters will be fixed at their mean values.
}
\value{
  the result is a \code{data.frame}, with named columns for each
  parameter in \code{par.ranges}. Each row represents one parameter set.
}
\author{ Felix Andrews \email{felix@nfrac.org} }
\seealso{
  \code{\link{sample}},
  \code{\link{quantile}},
  \code{\link{evalPars}} to then evaluate the parameter sets with a model in hydromad
}
\examples{
pars <- list(a = 1, b = 0:1, c = c(1,10), d = c(-2,-4,-8))

parameterSets(pars, 10, method = "random")

parameterSets(pars, 10, method = "latin")

parameterSets(pars, 10, method = "all.combinations")

parameterSets(pars, 20, method = "all.combinations")
}
\keyword{ utilities }


