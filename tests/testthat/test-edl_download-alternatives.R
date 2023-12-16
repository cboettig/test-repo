test_that("test", {

  dir <- tools::R_user_dir("test")
  dir.create(dir, FALSE, TRUE)
  netrc_file <- file.path(dir, "netrc")
  cookie_file <- file.path(dir, "cookies")
  
  # ensure we don't have an old cookie
  unlink(cookie_file)
  
  file.create(cookie_file)
  
  username="earthaccess"
  password="EDL_test1"
  
  contents <- paste("machine urs.earthdata.nasa.gov login",
                    username, "password", password)
  writeLines(contents, netrc_file)
  
  url <- "https://data.lpdaac.earthdatacloud.nasa.gov/lp-prod-protected/HLSL30.020/HLS.L30.T13QFD.2013161T171945.v2.0/HLS.L30.T13QFD.2013161T171945.v2.0.SAA.tif"

  dest <- tempfile(fileext = ".tif")
  

  h <- curl::new_handle(netrc = TRUE,
                        netrc_file = netrc_file,
                        cookiefile = cookie_file,
                        cookiejar = cookie_file,
                        verbose = TRUE)
  curl::curl_download(url, dest, handle = h)
  
  terra::rast(dest)
  

})
