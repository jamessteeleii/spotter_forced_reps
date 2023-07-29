# How much help do you need? An acute investigation into perceptions of
load lifted during forced repetitions.
Jürgen Giessing, James Steele James, P. Fisher

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

<div class="visNetwork html-widget html-fill-item-overflow-hidden html-fill-item" id="htmlwidget-7cf58ba0e4123271af65" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-7cf58ba0e4123271af65">{"x":{"nodes":{"name":["data","file","individual_data_plot","model_brms","model_data_plot","pp_check_plot","report","rhat_plot","tidy_model_brms","trace_plots","trace_pp_check_report","plot_individual_data","make_pp_check","plot_model_data","make_rhat_plot","get_data","fit_brms_model","make_trace_plots","get_tidy_model"],"type":["stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","stem","function","function","function","function","function","function","function","function"],"status":["uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","outdated","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate","uptodate"],"seconds":[0.01,2.7,1.76,1079.42,295.92,0.84,8.09,4.13,0.14,15.03,24,null,null,null,null,null,null,null,null],"bytes":[2128,4088,82,168237227,77,106982,895408,168392754,1941,51922362,3369653,null,null,null,null,null,null,null,null],"branches":[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],"label":["data","file","individual_data_plot","model_brms","model_data_plot","pp_check_plot","report","rhat_plot","tidy_model_brms","trace_plots","trace_pp_check_report","plot_individual_data","make_pp_check","plot_model_data","make_rhat_plot","get_data","fit_brms_model","make_trace_plots","get_tidy_model"],"color":["#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#78B7C5","#354823","#354823","#354823","#354823","#354823","#354823","#354823","#354823"],"id":["data","file","individual_data_plot","model_brms","model_data_plot","pp_check_plot","report","rhat_plot","tidy_model_brms","trace_plots","trace_pp_check_report","plot_individual_data","make_pp_check","plot_model_data","make_rhat_plot","get_data","fit_brms_model","make_trace_plots","get_tidy_model"],"level":[2,1,3,3,4,4,0,4,4,4,5,1,1,1,1,1,1,1,1],"shape":["dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","dot","triangle","triangle","triangle","triangle","triangle","triangle","triangle","triangle"]},"edges":{"from":["data","plot_individual_data","make_trace_plots","model_brms","data","fit_brms_model","get_tidy_model","model_brms","data","model_brms","plot_model_data","pp_check_plot","rhat_plot","trace_plots","make_pp_check","model_brms","make_rhat_plot","model_brms","file","get_data"],"to":["individual_data_plot","individual_data_plot","trace_plots","trace_plots","model_brms","model_brms","tidy_model_brms","tidy_model_brms","model_data_plot","model_data_plot","model_data_plot","trace_pp_check_report","trace_pp_check_report","trace_pp_check_report","pp_check_plot","pp_check_plot","rhat_plot","rhat_plot","data","data"],"arrows":["to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to","to"]},"nodesToDataframe":true,"edgesToDataframe":true,"options":{"width":"100%","height":"100%","nodes":{"shape":"dot","physics":false},"manipulation":{"enabled":false},"edges":{"smooth":{"type":"cubicBezier","forceDirection":"horizontal"}},"physics":{"stabilization":false},"interaction":{"zoomSpeed":1},"layout":{"hierarchical":{"enabled":true,"direction":"LR"}}},"groups":null,"width":null,"height":null,"idselection":{"enabled":false,"style":"width: 150px; height: 26px","useLabels":true,"main":"Select by id"},"byselection":{"enabled":false,"style":"width: 150px; height: 26px","multiple":false,"hideColor":"rgba(200,200,200,0.5)","highlight":false},"main":{"text":"","style":"font-family:Georgia, Times New Roman, Times, serif;font-weight:bold;font-size:20px;text-align:center;"},"submain":null,"footer":null,"background":"rgba(0, 0, 0, 0)","highlight":{"enabled":true,"hoverNearest":false,"degree":{"from":1,"to":1},"algorithm":"hierarchical","hideColor":"rgba(200,200,200,0.5)","labelOnly":true},"collapse":{"enabled":true,"fit":false,"resetHighlight":true,"clusterOptions":null,"keepCoord":true,"labelSuffix":"(cluster)"},"legend":{"width":0.2,"useGroups":false,"position":"right","ncol":1,"stepX":100,"stepY":100,"zoom":true,"nodes":{"label":["Up to date","Outdated","Stem","Function"],"color":["#354823","#78B7C5","#899DA4","#899DA4"],"shape":["dot","dot","dot","triangle"]},"nodesToDataframe":true},"tooltipStay":300,"tooltipStyle":"position: fixed;visibility:hidden;padding: 5px;white-space: nowrap;font-family: verdana;font-size:14px;font-color:#000000;background-color: #f5f4ed;-moz-border-radius: 3px;-webkit-border-radius: 3px;border-radius: 3px;border: 1px solid #808074;box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);"},"evals":[],"jsHooks":[]}</script>
