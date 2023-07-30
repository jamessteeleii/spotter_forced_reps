
<script src="README_files/libs/htmlwidgets-1.6.2/htmlwidgets.js"></script>
<link href="README_files/libs/vis-9.1.0/vis-network.min.css" rel="stylesheet" />
<script src="README_files/libs/vis-9.1.0/vis-network.min.js"></script>
<script src="README_files/libs/visNetwork-binding-2.1.2/visNetwork.js"></script>


# How much help do you need? An acute investigation into perceptions of load lifted during forced repetitions.

A study exploring how much a spotter assists with forced repetitions,
and the accuracy of a trainees perceptions of the amount of assistance
they provide.

## reproducibility

This project uses
[`renv`](https://rstudio.github.io/renv/articles/renv.html#reproducibility):

- `renv::snapshot()` save state
- `renv::restore()` load state

where state refers to package versions used by the project.

## targets analysis pipeline

This project also uses a function based analysis pipeline using
[`targets`](https://books.ropensci.org/targets/)

Useful console functions:

- `tar_edit()` opens a the make file
- `tar_make()` to run targets
- `tar_visnetwork()` to view pipeline

## This is the current pipeline

``` r
targets::tar_visnetwork(
  # this first argument is only required for static output
  # https://github.com/ropensci/targets/discussions/819
  callr_arguments = list(spinner = FALSE), 
  targets_only = TRUE)
```

<div class="visNetwork html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-e2960b6523cf88fe3e73" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-e2960b6523cf88fe3e73">{"x":{"nodes":{"name":["data","diagnostic_plots","file","individual_data_plot","individual_data_plot_tiff","marg_effs_plot","marg_effs_plot_tiff","model_brms","model_data_plot","model_data_plot_tiff","pp_check_plot","rhat_plot","tidy_model_brms","trace_plots"],"type":["stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem"],"status":["uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate"],"seconds":[0.01,24.05,2.7,0.04,1.71,3.88,3.25,1079.42,18.47,266,0.84,4.13,0.14,15.03],"bytes":[2128,3369116,4088,163928,82,191498414,76,168237227,3206934717,77,106982,168392754,1941,51922362],"branches":[null,null,null,null,null,null,null,null,null,null,null,null,null,null],"label":["data","diagnostic_plots","file","individual_data_plot","individual_data_plot_tiff","marg_effs_plot","marg_effs_plot_tiff","model_brms","model_data_plot","model_data_plot_tiff","pp_check_plot","rhat_plot","tidy_model_brms","trace_plots"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823"],"id":["data","diagnostic_plots","file","individual_data_plot","individual_data_plot_tiff","marg_effs_plot","marg_effs_plot_tiff","model_brms","model_data_plot","model_data_plot_tiff","pp_check_plot","rhat_plot","tidy_model_brms","trace_plots"],"level":[2,5,1,3,4,4,5,3,4,5,4,4,4,4],"shape":["dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot"]},"edges":{"from":["data","model_data_plot","model_brms","data","pp_check_plot","rhat_plot","trace_plots","data","model_brms","model_brms","data","model_brms","marg_effs_plot","model_brms","model_brms","file","individual_data_plot"],"to":["individual_data_plot","model_data_plot_tiff","trace_plots","model_brms","diagnostic_plots","diagnostic_plots","diagnostic_plots","marg_effs_plot","marg_effs_plot","tidy_model_brms","model_data_plot","model_data_plot","marg_effs_plot_tiff","pp_check_plot","rhat_plot","data","individual_data_plot_tiff"],"arrows":["to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":false},"manipulation":{"enabled":false},"edges":{"smooth":{"type":"cubicBezier","forceDirection":"horizontal"}},"physics":{"stabilization":false},"interaction":{"zoomSpeed":1},"layout":{"hierarchical":{"enabled":true,"direction":"LR"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":{"text":"","style":"font-family:Georgia, Times New Roman, Times, serif;font-weight:bold;font-size:20px;text-align:center;"},"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","highlight":{"enabled":true,"hoverNearest":false,"degree":{"from":1,"to":1},"algorithm":"hierarchical","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":true,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"},"legend":{"width":0.2,"useGroups":false,"position":"right","ncol":1,"stepX":100,"stepY":100,"zoom":true,"nodes":{"label":["Up to date","Stem"],"color":["#354823","#899DA4"],"shape":["dot","dot"]},"nodesToDataframe":true},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);"},"evals":[],"jsHooks":[]}</script>
