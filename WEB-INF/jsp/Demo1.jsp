<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<base href="<%=basePath%>">
	<link rel="stylesheet" href="static/css/smusic.css">
	<style>
		body{margin:0;padding:0;}
		.box{margin:10px auto;width:400px;}
		#showtime{margin:20px;margin-bottom: 20px;text-align: center;}
		span{font-size: 60px;}
		button{width:100px;height:100px;border-radius: 50px;border:0;outline:none ;margin:0 48px;font-size:24px;}
		#record{margin-top:20px;}
		#record div{width:400px;height:30px;border-bottom:1px dotted #666;}
		#record span{font-size:20px;}
		.left{float:left;}
		.right{float:right;}
	</style>
</head>
<body class="no-skin">
<div class="box">
	<div id="showtime">
		<span>00</span>
		<span>:</span>
		<span>00</span>
		<span>:</span>
		<span>00</span>
	</div>
	<div class="bnt">
		<button>记次</button>
		<button>启动</button>
	</div>
	<!--记录显示的次数-->
	<div id="record">
	</div>
</div>
<div class="grid-music-container f-usn">
	<div class="m-music-play-wrap">
		<div class="u-cover"></div>
		<div class="m-now-info">
			<h1 class="u-music-title"><small>...</small><small>...</small></h1>
			<div class="m-now-controls">
				<div class="u-control u-process">
					<span class="buffer-process"></span>
					<span class="current-process"></span>
				</div>
				<div class="u-control u-time">00:00/00:00</div>
				<div class="u-control u-volume">
					<div class="volume-process" data-volume="0.50">
						<span class="volume-current"></span>
						<span class="volume-bar"></span>
						<span class="volume-event"></span>
					</div>
					<a class="volume-control"></a>
				</div>
			</div>
			<div class="m-play-controls">
				<a class="u-play-btn prev" title="上一曲"></a>
				<a class="u-play-btn ctrl-play play" title="暂停"></a>
				<a class="u-play-btn next" title="下一曲"></a><br>

			</div>
		</div>
	</div>
	<div class="f-cb">&nbsp;</div>
	<div class="m-music-list-wrap"></div>
</div>
<script src="static/js/smusic.min.js"></script>
<script src="static/js/jquery.min.js"></script>
<script>
    //todo 计时器
    //添加事件
    $(function(){
        var min=0;
        var sec=0;
        var ms=0;
        var timer=null;
        var count=0;
        //点击第一个按钮
        $('.bnt button:eq(0)').click(function(){
            if($(this).html()=='记次'){
                if(!timer){
                    alert("没有开启定时器!");
                    return;
                }
                count++;
                var right1="<span class='right'>"+$('#showtime').text()+"</span>";
                var insertStr = "<div><span class='left'>记次"+count+"</span>" +right1+"</div>";
                $("#record").prepend($(insertStr));
            }else{
                min=0;
                sec=0;
                ms=0;
                count=0;
                $('#showtime span:eq(0)').html('00');
                $('#showtime span:eq(2)').html('00');
                $('#showtime span:eq(4)').html('00');
                $('#record').html('');
            }

        });
        //点击第二个按钮
        $('.bnt button:eq(1)').click(function(){
            if($(this).html()=='启动'){
                $(this).html('停止');
                $('.bnt button:eq(0)').html('记次');
                clearInterval(timer);
                timer=setInterval(show,10)
            }else{
                $(this).html('启动');
                $('.bnt button:eq(0)').html('复位');
                clearInterval(timer);
            }
        });
        //生成时间
        function show(){
            ms++;
            if(sec==60){
                min++;sec=0;
            }
            if(ms==100){
                sec++;ms=0;
            }
            var msStr=ms;
            if(ms<10){
                msStr="0"+ms;
            }
            var secStr=sec;
            if(sec<10){
                secStr="0"+sec;
            }
            var minStr=min;
            if(min<10){
                minStr="0"+min;
            }
            $('#showtime span:eq(0)').html(minStr);
            $('#showtime span:eq(2)').html(secStr);
            $('#showtime span:eq(4)').html(msStr);
        }
    })
	//todo 音乐播放器
    var musicList = [
        {
            title : '听见下雨的声音',
            singer : '周杰伦',
            cover  : '',
            src    : 'static/mp3/听见下雨的声音.mp3'
        },
        {
            title : '最长的电影',
            singer : '周杰伦',
            cover  : '',
            src    : 'static/mp3/最长的电影.mp3'
        },
        {
            title : '珊瑚海',
            singer : '周杰伦',
            cover  : '',
            src    : 'static/mp3/珊瑚海.mp3'
        },
        {
            title : '甜甜的',
            singer : '周杰伦',
            cover  : '',
            src    : 'static/mp3/甜甜的.mp3'
        }
    ];
    new SMusic({
        musicList:musicList
    });

</script>
</body>
</html>