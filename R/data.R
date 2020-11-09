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

#' the main table of Lambert et al., Cell 2018: "The human transcription factors"
#' @docType data
#' @format tibble
"lamb_main_20201101"

#' an hg19-based data.frame with gene addresses
#' @docType data
#' @note Faster response than GRanges/genes on TxDb.  `genes_df_hg19[sym,]` gives one row with seqnames, start, end, etc.
#' @format data.frame
"genes_df_hg19"

#' a TnT gene track with gene symbols as display_id, hg19
#' @docType data
#' @format TnT GeneTrack
"tnt_gt_sym"

#' a TnT transcript track confined to chr14, hg19
#' @docType data
#' @format TnT GeneTrack
"tnt_txtr_14"
