if (interactive()) {
  suppressPackageStartupMessages(
    require(devtools)
  )

  options(
    repos = c(
      CRAN = sprintf(
        "https://packagemanager.posit.co/cran/latest/bin/linux/manylinux_2_28-%s/%s",
        R.version["arch"],
        substr(getRversion(), 1, 3)
      )
    )
  )
}
