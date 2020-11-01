#' a GRanges derived from the EBI/EMBL GWAS catalog of 1 Nov 2020
#' @docType data
#' @format GenomicRanges GRanges instance
#' @note The 'value' field is the result of `pmin(hits_near_ormdl3_trunc10$PVALUE_MLOG,10)`,
#' which is convenient to see variation in significance, which would otherwise be crushed 
#' down owing to mlog values in the 100s.
"hits_near_ormdl3_trunc10"


#' a transcript catalog on chr17
#' @docType data
#' @format GenomicRanges GRanges instance, generated using biovizBase::crunch on EnsDB.Hsapiens.v79.
#' The resulting GRanges was then limited to a 5Mb window starting at 38e6.  The mcols column
#' 'type' is set to 'exon'.
"txdata_near_ormdl3"
