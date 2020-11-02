tntData = function(x) slot(x, "Data")

# several imports below are artificial owing to some gaps in TFutils namespace

#' set TnT tooltip data using EnsDb metadata
#' @import TnT 
#' @importFrom ensembldb select
#' @importFrom S4Vectors elementMetadata
#' @importFrom BiocFileCache bfcadd
#' @import EnsDb.Hsapiens.v79
#' @import GenomicRanges
#' @param view a TnT TxTrack instance 
#' @param ensobj an EnsDb instance
#' @param cols2use character() vector with elements drawn from result of `columns(ensobj)`
#' @return TxTrack revised with specific tooltip data
#' @export
reset_tooltip = function(view, 
   ensobj=EnsDb.Hsapiens.v79::EnsDb.Hsapiens.v79,
   cols2use = c("GENEID", "SYMBOL", "TXBIOTYPE")) {
  vd = tntData(view)
  vd$tooltip = ensembldb::select(ensobj, 
     keys = elementMetadata(vd)$tooltip$tx_id, keytype="TXID", columns=cols2use)
  slot(view, "Data") = vd
  view
}

#' set TnT glyph color data using EnsDb metadata
#' @param view a TnT TxTrack instance 
#' @param ttcolumn column name that is already present in tooltip metadata
#' @return TxTrack
#' @export
reset_color = function(view, ttcolumn="TXBIOTYPE") {
  vd = tntData(view)
  trackData(view)$color = TnT::mapcol(elementMetadata(vd)$tooltip[[ttcolumn]])
  view
}


#' set TnT display labeling for a transcript set
#' @param view a TnT TxTrack instance 
#' @param cols2use column names already present in tooltip metadata
#' @return TxTrack display label reset using TnT::strandlabel
#' @export
reset_display_label = function(view, cols2use=c("SYMBOL", "TXBIOTYPE")) {

        vd = tntData(view)
        ttdf = elementMetadata(vd)$tooltip
        rm(vd)
        newlabs = do.call( paste, ttdf[, cols2use] )
        stran = strand(TnT::trackData(view))
        newlab = TnT::strandlabel(newlabs, stran)
        trackData(view)$display_label <- newlab
        view
}

