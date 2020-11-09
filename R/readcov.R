#' produce a coverage RLE given a gene symbol, hg19-based
#' @importFrom GenomicRanges GRanges
#' @importFrom IRanges IRanges
#' @importFrom Rsamtools BamFile
#' @importFrom Rsamtools ScanBamParam
#' @importFrom GenomicAlignments coverage
#' @param sym a gene symbol
#' @param bamf a path to indexed BAM file
#' @param radius numeric(1) defaulting to zero, upstream/downstream extra reach
#' @note Uses `genes_df_hg19` to find address of gene.
#' @examples
#' if (requireNamespace("RNAseqData.HNRNPC.bam.chr14")) {
#'   f1 = RNAseqData.HNRNPC.bam.chr14::RNAseqData.HNRNPC.bam.chr14_BAMFILES[1]
#'   read_covg_by_symbol("HNRNPC", f1)
#' }
#' @export
read_covg_by_symbol = function(sym, bamf, radius=0) {
  addr = biocwk312::genes_df_hg19[sym,]
  if (nrow(addr)!=1) stop("need sym with unique addr in biocwk312::genes_df_hg19")
  curchr = addr$seqnames
  region = GenomicRanges::GRanges(curchr, IRanges::IRanges(addr$start, addr$end), strand=addr$strand)
  region = region+radius
  bamf = Rsamtools::BamFile(bamf)
  parm = Rsamtools::ScanBamParam(which=region)
  GenomicAlignments::coverage(bamf, param=parm)[[curchr]]
}

#' produce a TnT::LineTrack with coverage information for a selected gene+radius
#' @importFrom S4Vectors runLength runValue
#' @param sym a gene symbol
#' @param bamf a path to indexed BAM file
#' @param radius numeric(1) defaulting to zero, upstream/downstream extra reach
#' @param \dots passed to LineTrack, so can include color, etc.
#' @examples
#' if (requireNamespace("RNAseqData.HNRNPC.bam.chr14")) {
#'   f1 = RNAseqData.HNRNPC.bam.chr14::RNAseqData.HNRNPC.bam.chr14_BAMFILES[1]
#'   linetrack_covg_by_symbol("HNRNPC", f1, color="gray")
#' }
#' @export
linetrack_covg_by_symbol = function(sym, bamf, radius=0, ...) {
  myr = read_covg_by_symbol(sym, bamf, radius=0)
#  interp = rep(runValue(myr), runLength(myr))
#  addrs = seq_len(length(interp))
#  left = min(which(interp>0))
#  right = max(which(interp>0))
#  counts = interp[left:right]
#  pos = addrs[left:right]
  pos = cumsum(runLength(myr))
  counts = runValue(myr)
  last = length(counts)
  pos = pos[-last]
  counts = counts[-last]
  chr = genes_df_hg19[sym,]$seqnames
  gr = GenomicRanges::GRanges(chr, IRanges(pos,width=1))
  gr$value = counts
  TnT::LineTrack(gr, ...) 
}
