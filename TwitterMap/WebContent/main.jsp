<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="tmpkg.DataHelper,java.util.*, tmpkg.Twitter, org.apache.commons.lang3.StringEscapeUtils"%>
<!DOCTYPE html>
<html>
<head>
<title>Twitter Map</title>
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBkHDmiIsHgitxBSjmypi2Mk9OgCpbe6nA&sensor=true&libraries=visualization"></script>
<script>
	<% DataHelper dh = new DataHelper();
		ArrayList<Twitter> list = dh.getAllData();
		int datanum = list.size(); %>
	var mapdata = [
	<% for (int i=0; i<datanum-1;i++) {
		Twitter t = list.get(i);
		String username = StringEscapeUtils.escapeEcmaScript(t.getUsername());
		String text = StringEscapeUtils.escapeEcmaScript(t.getText());
		out.println("['"+username+"', '"+text+"', "+t.getLatitude()+", "+t.getLongtitude()+", '"+t.getKeyword()+"', '"+t.getTimestamp()+"'],");
	}
		Twitter t = list.get(datanum-1);
		String username = StringEscapeUtils.escapeEcmaScript(t.getUsername());
		String text = StringEscapeUtils.escapeEcmaScript(t.getText());
		out.println("['"+username+"', '"+text+"', "+t.getLatitude()+", "+t.getLongtitude()+", '"+t.getKeyword()+"', '"+t.getTimestamp()+"'],");
	%>
	
	];
    var map, heatmap;
    var markers = [];
    var heatlocs = [];
    function initialize() {
      var mapOptions = {
        zoom: 2,
        center: new google.maps.LatLng(40.7127, -74.0059)
      };
      map = new google.maps.Map(document.getElementById('map-canvas'),
          mapOptions);
      var infowindow = new google.maps.InfoWindow();
 
      var i, marker;
      for (i = 0;i<mapdata.length;i++) {
      	marker = new google.maps.Marker({
      		position: new google.maps.LatLng(mapdata[i][2], mapdata[i][3]),
      		map: map
      	});
      	markers[i] = marker;
      	heatlocs[i] = new google.maps.LatLng(mapdata[i][2], mapdata[i][3]);
      	google.maps.event.addListener(marker, 'click', (function(marker, i) {
      		return function() {
      			var contentstr = '<div>'
      			+'<h2> @'+unescape(mapdata[i][0])+' :</h2>'
      			+'<p>"'+unescape(mapdata[i][1])+'"</p>'
      			+'<p>At '+mapdata[i][5]+'</p>'
      			+'</div>';
      			infowindow.setContent(contentstr);
      			infowindow.open(map,marker);
      		}
      	})(marker, i));
      }
      var pointArray = new google.maps.MVCArray(heatlocs);
      heatmap = new google.maps.visualization.HeatmapLayer({
    	    data: pointArray
    	  });
      heatmap.set('radius', 18);
    }
    
    function setAllMap(map) {
    	for (var i = 0; i < markers.length; i++) {
    		markers[i].setMap(map);
    	}
    }
    
    function changeMap(sel) {
    	if(sel.value=="0") {
    		heatmap.setMap(null);
    		setAllMap(map);
    	}
    	else{
    		setAllMap(null);
    		heatmap.setMap(map);
    	}
    }
    
    function changeKeyword(sel) {
    	setAllMap(null);
    	if(sel.value=="0")
    		setAllMap(map);
    	else{
        	for (var i = 0; i < markers.length; i++) {
        		if (sel.value == mapdata[i][4])
        			markers[i].setMap(map);
        	}
    	}
    }

    google.maps.event.addDomListener(window, 'load', initialize);
    
    </script>
<style>
#header {
	background-color: black;
	color: white;
	text-align: center;
	padding: 5px;
}

#nav {
	line-height: 30px;
	background-color: #eeeeee;
	height: 500px;
	width: 100px;
	float: left;
	padding: 5px;
}

#section {
	width: 350px;
	float: left;
	padding: 10px;
}

#footer {
	background-color: black;
	color: white;
	clear: both;
	text-align: center;
	padding: 5px;
}
</style>
</head>
<body>
	<div id="header">
		<h1>Twitter Map</h1>
	</div>
	
	<div id="nav">
		Authors:<br>
		Wei & Yijun<br>
		<br>
		Keyword:<br>
		<select id="keywordSelect" onchange="changeKeyword(this)">
			<option value="0">All</option>
			<option value="sport">sport</option>
			<option value="game">game</option>
			<option value="lose">lose</option>
			<option value="win">win</option>
		</select>
		<br>
		Map Layer:<br>
		<select id="heatmapSelect" onchange="changeMap(this)">
			<option value="0">normal</option>
			<option value="1">heat map</option>
		</select>
		
	</div>
	<div id="section">
		<div id="map-canvas" style="width:800px;height:500px;"></div>
	</div>
	<div id="footer">
		By Wei Dai & Yijun Wang
	</div>
	
</body>
</html>