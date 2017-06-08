# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	Highcharts.chart 'currency-chart',
		title: text: 'Currency'
		yAxis: title: text: 'USD'
		xAxis: categories: JSON.parse($('#currency-chart').attr('data-chart-categories'))
		series: JSON.parse($('#currency-chart').attr('data-chart-series'))
