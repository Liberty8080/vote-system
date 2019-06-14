<%@ page import="java.sql.SQLException" %>
<%@ page import="model.VoteTheme" %>
<%@ page import="javafx.scene.chart.Axis" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: jacob
  Date: 6/8/19
  Time: 4:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="voteDao" class="dao.VoteDao" scope="session"/>
<html>
<head>
    <title>查看投票</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    <style>
        .card {
            width: 400px;
        }

        .container {
            margin-top: 50px;
        }

        .col-lg-4 {
            margin-right: 30px;
        }
    </style>
</head>
<body>
<nav class="navbar  navbar-dark bg-dark" id="nav0">
    <a class="navbar-brand" href="Home.html"><h1 style="font-family: KacstArt,fantasy">vote.com</h1></a>
</nav>
<div class="container">
    <div class="row">
        <div class="col-lg-4">

            <%
                int id = Integer.parseInt(request.getParameter("tid"));
                List<String> xAxis = new ArrayList<>();
                List<Integer> yAxis = new ArrayList<>();
                Map<String, Integer> options;
                Set<String> set;
                try {
                    VoteTheme v = voteDao.findVoteById(id);
                    options = v.getOptions();
                    set = options.keySet();
                    out.print(
                            "<div class='card'>\n" +
                                    "<img class='card-img-top' src='image/cyberpunk.jpg' alt='Card image cap'>\n" +
                                    "<div class='card-body'>");
                    out.print("<h5 class='card-title text-center'>" + v.getTheme() + "</h5>\n");
                    out.print("<p class='card-text'>" + v.getInfo() + "</p>\n");
                    out.print("<form action='#' method='post' id='makeVoteForm'>\n");
                    for (String option : set) {
                        xAxis.add(option);
                        yAxis.add(options.get(option));
                        out.print("  <div class=\"form-check\">\n" +
                                "            <input class='form-check-input' type='radio' name='voteOptions' id='" + option + "'  value=" + options.get(option) + " >\n" +
                                "            <label class=\"form-check-label\" for='" + option + "'>\n" +
                                "                " + option +
                                "            </label>\n" +
                                "        </div>");
                    }
                    out.print("");
                    out.print("<button class=\"btn btn-primary\" id=\"makeVote\" onclick='return addCount()'>点击投票</button>\n\n");
                    out.print("</div></div>");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                System.out.println(Arrays.toString(xAxis.toArray()));
            %>


        </div>
        <div class="col-lg-6" id="main"></div>
    </div>

</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.2.1/echarts.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById("main"));

    // 指定图表的配置项和数据
    var param = {
        title: {
            text: '投票结果'
        },
        tooltip: {},
        legend: {
            data: ['票数']
        },
        xAxis: {
            data: <%=Arrays.toString(xAxis.toArray())%>
        },
        yAxis: {},
        series: [{
            name: '票数',            type: 'bar',
            data: <%=Arrays.toString(yAxis.toArray())%>
        }]
    };
    setInterval(myChart.setOption(param),1000);


    function  addCount() {
     var op =  $("input[name='voteOptions']:checked").next("label").text();
     var num = $('input:radio:checked').val();
        window.location.href='addCount.jsp?id=<%=id%>&string='+op+'&num='+num+'';
        return false;
    }

    // 使用刚指定的配置项和数据显示图表。

</script>
</body>
</html>
