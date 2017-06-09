# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
	Highcharts.chart 'currency-chart',
		title:
      text: 'Currency'
    tooltip:
      shared: true
		yAxis: [
      title:
        text: 'Buy price in USD'
      labels:
        format: 'US$ {value:,.2f}'
    ,
      title:
        text: 'NASDAQ Index points'
      labels:
        format: '{value} points'
      opposite: true
    ]
		xAxis: categories: JSON.parse($('#currency-chart').attr('data-chart-categories'))
		series: JSON.parse($('#currency-chart').attr('data-chart-series'))
