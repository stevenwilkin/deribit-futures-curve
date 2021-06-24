// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"

import Chart from 'chart.js/auto';
import 'chartjs-adapter-date-fns';
import format from 'date-fns/format'

var ctx = document.getElementById('chart').getContext('2d');
var myChart = new Chart(ctx, {
  type: 'line',
  data: data,
  options: {
    scales: {
      x: {
        type: 'time',
      },
    },
    plugins: {
      legend: {
        display: false
      },
      tooltip: {
        displayColors: false,
        callbacks: {
          title: function(context) {
            return context[0].parsed.y + '%';
          },
          label: function(context) {
            return format(context.raw.x, 'do LLLL Y');
          },
        }
      }
    }
  }
});
