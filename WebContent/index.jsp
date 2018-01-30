<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	out.println("转发内容"+request.getAttribute("msg"));
	String lsCity=(String)request.getAttribute("msg");
%>
<html>
<head>
<base href="<%=basePath%>">
<title>地图找房</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
<style type="text/css">
html {
	height: 100%
}

body {
	font: 100%/1.4 Verdana, Arial, Helvetica, sans-serif;
	height: 100%;
	margin: 0px;
	padding: 0px;
}

#menu {
	padding: 5px 0px 0px 0px;
	width: 100%;
	height: 7%;
}

#main {
	width: 100%;
	float: left;
	position: fixed;
	height: 87%;
}
</style>

<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=NOzjofU9ykilQP9aRhwppr3jWewmxVBz">
    </script>

<script type="text/javascript">
    var map; // 创建地图全局实例
    var ls_City = '<%=lsCity%>';
    alert(ls_City);
    //var map = new BMap.Map("container",{mapType: BMAP_HYBRID_MAP});  
    
	function load_map() {
		//从数据库查询数据，json格式
		map = new BMap.Map("main",{mapType: BMAP_HYBRID_MAP});//卫星地图
		var point = new BMap.Point(116.404, 39.915);//北京
		var geolocation = new BMap.Geolocation();//实例化
		map.centerAndZoom(point, 6); //初始化地图
		map.enableScrollWheelZoom();//滑轮缩放大小
		map.addControl(new BMap.NavigationControl());
		map_tag();
		location();
		
		
	}
	function map_tag() {
		var objRecords = eval("(" + ls_City + ")");//后台得到的数据包含经纬度，json格式的
		alert(objRecords[1]);
		var points = new Array();
		for (var i = 0; i < objRecords.length; i++) {
			var marker = new BMap.Marker(new BMap.Point(objRecords[i].X,
					objRecords[i].Y));//创建标注对象
			points.push(marker);
		}
		for (var i = 0; i < objRecords.length; i++) {
			map.addOverlay(points[i]);
		}
	}
	function location(){
		var geolocation = new BMap.Geolocation();
		geolocation.getCurrentPosition(function(r){
			if(this.getStatus() == BMAP_STATUS_SUCCESS){
				var mk = new BMap.Marker(r.point);
				map.addOverlay(mk);
				map.panTo(r.point);
				//alert('您的位置：'+r.point.lng+','+r.point.lat);
			}
			else {
				alert('failed'+this.getStatus());
			}        
		},{enableHighAccuracy: true})
	}
	function JSON1() {
		var objRecords1 = eval("(" + ls_City + ")");//后台得到的数据包含经纬度，json格式的
		//alert(JSON.stringify(objRecords1));
		alert(JSON.stringify(objRecords1[0]));
		alert(JSON.stringify(objRecords1[1]));
	}

	function JSONSTR() {
		window.alert(ls_City);
	}
	function CancelTag() {
		map.clearOverlays();
	}
</script>
</head>

<body onLoad="load_map()">
	<div id="menu">
		<input name="button1" type="button" id="button1" onClick="map_tag();"
			value="批量标注"
			style="width: 150px; height: 40px; margin: 0px 0px 0px 5px">
		<input name="button2" type="button" id="button2"
			onClick="CancelTag();" value="取消标注"
			style="width: 150px; height: 40px;"> <input name="button2"
			type="button" id="button2" onClick="JSON1();" value="JSON对象"
			style="width: 150px; height: 40px;"> <input name="button2"
			type="button" id="button2" onClick="JSONSTR();" value="JSON字符串"
			style="width: 150px; height: 40px;">
	</div>
	<hr>
	<div id="main"></div>

</body>
</html>

