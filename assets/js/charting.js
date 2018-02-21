// Following step by step here:
// https://medium.com/@kiminoa/phoenix-and-brunch-adding-a-new-javascript-file-for-inline-template-invocation-349bcb68f4e4
// http://phoenixframework.org/blog/static-assets
// https://elixirforum.com/t/setup-import-and-use-javascript-in-phoenix/7616/2

export var ChartThisNow = {
  chart_this_now: function() {
    console.log("inside chart");

    // ajax call here to a route, returns data we want.

    var request = $.ajax({
      type: "get",
      url: "/chart_data",
      data: ""
    });

    request.done(function(response){
      var chartLabels = response[0];
      var chartData = response[1];

      var ctx = document.getElementById('myChart').getContext('2d');
      var chart = new Chart(ctx, {
          // The type of chart we want to create
          type: 'line',

          // The data for our dataset
          data: {
              labels: chartLabels,
              datasets: [{
                  label: "Career Prize Money - Singles and Doubles combined",
                  backgroundColor: 'rgb(255, 99, 132)',
                  borderColor: 'rgb(255, 99, 132)',
                  data: chartData,
              }]
          },

          // Configuration options go here
          options: {}
      });
    });

  }
}
