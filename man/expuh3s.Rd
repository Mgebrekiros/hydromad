\name{expuh3s}
\alias{expuh3s}
\alias{expuh3s.sim}
\title{ Exponential components transfer function models with layered
  slowflow stores }
\description{
  A unit hydrograph with a quickflow pathway and two layered slowflow
  pathways modelling recharge to groundwater in order to allow modelling
  of long-term disconnection of slowflow stores from streamflow.
}
\usage{
expuh3s.sim(U, delay = 0,v_s,
          tau_s = 0, tau_q = 0, tau_g = 0,
          R,G_1=0,loss,G_2,
          Xs_0 = 0, Xq_0 = 0, X3_0 = 0,
          pars = NULL,
          return_components = FALSE,
	  na.action = na.pass,
          epsilon = hydromad.getOption("sim.epsilon"))
}
\arguments{
  \item{U}{
    input time series (units below assume ML/day)
  }
  \item{delay}{
    lag (dead time) between input and response, in time steps.
  }
  \item{v_s}{
    Fraction of effective rainfall that goes to groundwater
  }
  \item{tau_q}{
    Recession coefficient for quickflow (days)
  }
  \item{tau_s}{
    Recession coefficient for soil store (G_1) discharge (days)
  }
  \item{tau_g}{
    Recession coefficient for groundwater store (G_2) discharge (days)
  }
  \item{R}{
    Maximum recharge from G_1  to G_2 (ML/day)
  }
  \item{G_1}{
    storage threshold to stop recharge (ML) (less than zero)
  }
  \item{loss}{
    Groundwater loss (ML/day)
  }
  \item{G_2}{
    storage threshold to stop groundwater loss (ML) (less than zero)
  }
  \item{Xs_0, Xq_0, X3_0}{
    initial values of the exponential components.
  }
  \item{pars}{
    the parameters as a named vector. If this is given, it
    will over-ride the named parmameter arguments. 
  }
  \item{return_components}{
    whether to return all component time series.
  }
  \item{na.action}{
    function to remove missing values,
    e.g. \code{\link[=na.omit.ts]{na.omit}}.
  }
  \item{epsilon}{
    values smaller than this in the output will be set to zero.
  }
}
\details{

  The \code{expuh3s} model consists of a single quickflow pathway
  modelled as an exponential store, and a slowflow pathway comprised of
  two layered stores.

  Each slowflow store is modelled as a \code{\link{leakyExpStore}}, which has a
  loss term, has no flow when the store drops below a given level, and
  can therefore model longer-term disconnection of a store from streamflow.
  
  Adapted from Herron and Croke (2009):
  
  The upper store, G1, receives rainfall inputs and discharges to the
  stream, Qs and recharges the lower store. G1 has a lower limit of 0,
  where flow ceases representing the fully 'drained' condition. Conceptually, the upper
  store can be viewed as a perched water table, which develops in
  response to rain and tends to be relatively short-lived, perhaps
  seasonal. Thus the time constant, \code{tau_s}, for discharge from the
  'soil' store will be somewhere between that for quickflow,
  \code{tau_q} and the groundwater discharge constant, \code{tau_g}.

  G2 is recharged from G1 when \code{G1>G_1} and discharges to the
  stream \code{Q_g} when \code{G2>0}. The sum of \code{Q_s} and
  \code{Q_g} represents the total slowflow pathway. We assume that all
  extraction and natural groundwater losses (\code{loss}) are from
  G2. The approach avoids the need to specify a maximum capacity for
  either storage, but the introduction of a recharge term, \code{R}
  between the stores adds a new parameter.

  Recharge is represented by a constant rate \code{R} which ceases
  when \code{G1<G_1}, diminishing linearly to that point when
  \code{thres<G1<thres+loss}. Setting \code{G_1=0} (the default) ceases recharge when flow ceases.
  
}
\value{
	the model output as a \code{\link{ts}} object,
	with the same dimensions and time window as the input \code{U}.
	If \code{return_components = TRUE}, it will have multiple
	columns named
	\code{Xs}, \code{Xq} and \code{Xg}.
}
\references{
	Herron, N.F. and B.F.W. Croke (2009). IHACRES-3S - A 3-store formulation for modelling 
groundwater-surface water interactions. In Anderssen, R.S., R.D. Braddock and L.T.H. Newham (eds) \emph{18th World IMACS Congress and MODSIM09 International Congress on Modelling and Simulation.} Modelling and Simulation Society of Australia and New Zealand and International Association for Mathematics and Computers in Simulation, July 2009, pp. 3081-3087. ISBN: 978-0-9758400-7-8. \link{http://www.mssanz.org.au/modsim09/I1/herron.pdf}
}
\author{ Joseph Guillaume \email{joseph.guillaume@anu.edu.au} }
\seealso{
  \code{\link{expuh}},\code{\link{leakyExpStore}}
}
\keyword{ ts }

