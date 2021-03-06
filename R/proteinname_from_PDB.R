#' Get protein name from PDB id
#'
#' @param pdb character vector fo 4-letter PDB codes
#'
#' @return character vector of protein names
#'
#' @examples
#' get_pdb_proteinname("1TGM")
#' "Basic phospholipase A2 VRV-PL-VIIIa"
#'
#' @describeIn
#' Utilizing PDB Web API to search protein names of PDB
#' https://www.rcsb.org/pdb/software/rest.do#descEntity
#'
#' @export

get_PDB_proteinname <- function(pdb_ids){
  
  if(!length(pdb_ids)){
    return(NA_real_)
  }
  
  map(.x = pdb_ids, .f = function(x){
    query <- stringr::str_c("http://www.rcsb.org/pdb/rest/describeMol?structureId=", x)
    content <- httr::GET(query) %>%
      httr::content()
    
    protein_names <- xml2::xml_find_all(content, "//macroMolecule") %>%
      xml2::xml_attr("name") %>%
      unique()
  })
  
}
