 <%
 		pageContext.setAttribute("path",request.getContextPath());
 %>
	<script type="text/javascript" src="${path }/static/js/jquery-3.2.1.min.js"></script><!--引入最新jQuery-->
	<script type="text/javascript" src="${path }/static/js/jquery.form-3.51.0.js"></script><!--jQuery.form.js-->
    <link rel="stylesheet" type="text/css" href="${path }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"><!--bootstrap样式 -->
    <link rel="stylesheet" type="text/css" href="${path }/static/bootstrapvalidator-master/dist/css/bootstrapValidator.min.css"/><!--bootstrapValidator样式 -->
    <script src="${path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${path }/static/bootstrapvalidator-master/dist/js/bootstrapValidator.js"></script><!--带众多常用默认验证规则的 -->
	<script type="text/javascript" src="${path }/static/bootstrapvalidator-master/dist/js/bootstrapValidator.min.js"></script><!--不带常用规则，需自定义规则 -->
	<link rel="stylesheet" type="text/css" href="${path }/static/flipclock/flipclock.css"/><!--flipclock样式 -->
	<script type="text/javascript" src="${path }/static/flipclock/flipclock.min.js"></script><!--flipclock JS -->
	<%-- <link rel="stylesheet" type="text/css" href="${path }/static/bootstrap-clockpicker/bootstrap-clockpicker.min.css">
	<script type="text/javascript" src="${path }/static/bootstrap-clockpicker/bootstrap-clockpicker.min.js"></script> --%>
	<div class="your-clock"></div>
	<script type="text/javascript">
		var clock = new FlipClock($('.your-clock'), {//对应的是(天,时,分,12小时制,24小时制,计数)
			clockFace: 'TwentyFourHourClock',//计数模式
		});
		//设置时间格式的时钟
		var date = new Date();
	        clock = $('.clock').FlipClock(date, {
	        clockFace: 'TwentyFourHourClock'
		});
	</script>
