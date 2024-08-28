
return {
  {
    'kyazdani42/nvim-web-devicons',
    opts = {
      default = true,
      color_icons = true,
      -- strict = true,
      override = {
        lisp = {
          icon = "λ",
          color = "#9f1d20",
          name = "lisp"
        },
        R = {
          icon = "",
          color = "#2369bd",
          name = "R"
        },
        js = {
          icon = "",
          color = "#FFBA52",
          cterm_color = "222",
          name = "javascript"
        },
        dockerfile = {
          icon = "",
          color = "#FFAF87",
          name = "dockerfile"
        },
        text = {
          icon = "",
          color = "#deaded",
          name = "text"
        },
        ps1 = {
          icon = "",
          color = "#428850",
          name = "ps1"
        },
        tsv = {
          icon = "",
          color = "#428850",
          name = "csv"
        },
        csv = {
          icon = "",
          color = "#428850",
          name = "csv"
        },
        xlsx = {
          icon = "",
          color = "#428850",
          name = "excel"
        },
        vim = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "text"
        },
        default = {
          icon = "",
          color = "#deaded",
          name = "text"
        },
      },
      override_by_filename = {
        ["Gulpfile.js"] = {
          icon = "",
          color = "#f1502f",
          name = "Gulpfile"
        },
        ["Dockerfile"] = {
          icon = "",
          color = "#FFAF87",
          name = "dockerfile"
        },
        ["docker-compose.yaml"] = {
          icon = "",
          color = "#FFAF87",
          name = "dockerfile"
        },
        ["NEWS"] = {
          icon = "",
          color = "#FFAF87",
          name = "News"
        },
      },
      override_by_extension = {
        ["txt"] = {
          icon = "",
          color = "#DEADED",
          name = "text"
        },
        ["list"] = {
          icon = "",
          color = "#f1502f",
          name = "text"
        },
        ["m4"] = {
          icon = "",
          color = "#f1502f",
          name = "m4"
        },
        ["in"] = {
          icon = "",
          color = "#428850",
          name = "autotools"
        },
        ["ac"] = {
          icon = "",
          color = "#428850",
          name = "autotools"
        },
        ["asc"] = {
          icon = "",
          color = "#f1502f",
          name = "gpg"
        },
        ["gpg"] = {
          icon = "",
          color = "#f1502f",
          name = "gpg"
        },
        ["dat"] = {
          icon = "",
          color = "#428850",
          name = "Data"
        },
        ["asd"]= {
          icon = "λ",
          color = "#428850",
          cterm_color = "65",
          name = "lisp"
        },
        ["tsv"] = {
          icon = "",
          color = "#428850",
          name = "tsv"
        },
        ["pdf"] = {
          icon = "",
          color = "#f1502f",
          name = "PDF"
        },
        ["xz"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["gz"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["zstd"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["bz2"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["zpaq"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["tar.xz"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["tar.gz"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["tar.bz2"] = {
          icon = "",
          color = "#f1502f",
          name = "archive"
        },
        ["deb"] = {
          icon = "",
          color = "#f1502f",
          name = "Debian"
        },
        ["patch"] = {
          icon = "",
          color = "#f1502f",
          name = "patch"
        },
        ["AppImage"] = {
          icon = "",
          color = "#f1502f",
          name = "AppImage"
        },
      }
    }
  }
}
