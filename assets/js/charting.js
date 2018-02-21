// Following step by step here:
// https://medium.com/@kiminoa/phoenix-and-brunch-adding-a-new-javascript-file-for-inline-template-invocation-349bcb68f4e4
// http://phoenixframework.org/blog/static-assets
// https://elixirforum.com/t/setup-import-and-use-javascript-in-phoenix/7616/2

export var ChartThisNow = {
  chart_this_now: function() {
    console.log("inside chart");
    var ctx = document.getElementById('myChart').getContext('2d');
    var chart = new Chart(ctx, {
        // The type of chart we want to create
        type: 'line',

        // The data for our dataset
        data: {
            labels: ["January", "February", "March", "April", "May", "June", "July"],
            datasets: [{
                label: "My First dataset",
                backgroundColor: 'rgb(255, 99, 132)',
                borderColor: 'rgb(255, 99, 132)',
                data: [0, 10, 5, 2, 20, 30, 45],
            }]
        },

        // Configuration options go here
        options: {}
    });
  }
}
