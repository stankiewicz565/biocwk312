% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/readcov.R
\name{read_covg_by_symbol}
\alias{read_covg_by_symbol}
\title{produce a coverage RLE given a gene symbol, hg19-based}
\usage{
read_covg_by_symbol(sym, bamf, radius = 0)
}
\arguments{
\item{sym}{a gene symbol}

\item{bamf}{a path to indexed BAM file}

\item{radius}{numeric(1) defaulting to zero, upstream/downstream extra reach}
}
\description{
produce a coverage RLE given a gene symbol, hg19-based
}
\note{
Uses \code{genes_df_hg19} to find address of gene.
}
\examples{
if (requireNamespace("RNAseqData.HNRNPC.bam.chr14")) {
  f1 = RNAseqData.HNRNPC.bam.chr14::RNAseqData.HNRNPC.bam.chr14_BAMFILES[1]
  read_covg_by_symbol("HNRNPC", f1)
}
}
