$(function(){
	window.onload = (e) => {
		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined && item.type === "addnews")
			{
				$("#container").show();
				$("#container_cpanel").show();
				$("#HeadlineTitle1").attr('src',"");
				$("#HeadlineTitle2").text(" ");
				$("#Headline1").text(" ");
				$("#Headline2").text(" ");
				$("#recentArrest1").text(" ");
				$("#recentArrest2").text(" ");
				$("#recentArrest3").text(" ");
			}
			else if (item !== undefined && item.type === "close") {
				$("#container").hide();
				$("#container_cpanel").hide();
			}
			else if (item !== undefined && item.type === "ui") {
				if (item.display === true) {
                    $("#container").show();
				} else{
                    $("#container").hide();
                }
			
				
				 $("#HeadlineTitle1").attr('src',item.headlineTitle1);
			
				$("#HeadlineTitle2").text(item.headlineTitle2);
		
				$("#Headline1").text(item.headline1);
		
				$("#Headline2").text(item.headline2);
			
			//---------------------------------------------//
				$("#recentArrestHeader").text('');

				$("#recentArrest1").text(item.arrest1);
		
				$("#recentArrest2").text(item.arrest2);
		
				$("#recentArrest3").text(item.arrest3);
			}
		});
	$("#container").hide();
	$("#container_cpanel").hide();
	};
});
document.onkeyup = function (data) {
	if (data.which == 27) {
		close();
	}
};

function close() {
	$("#container").css('display', 'none');
	$("#container_cpanel").css('display', 'none');
	$.post('https://nxo-newspaper/close', JSON.stringify({}));
}
function previewevent() {
	$("#HeadlineTitle1").attr('src',document.getElementById("imageaddress").value);
	$("#HeadlineTitle2").text(document.getElementById("addtitle").value);
	$("#Headline2").text(document.getElementById("addRightarticle").value);
	$("#Headline1").text(document.getElementById("addleftarticle").value);
}
function saveevent() {
	imageaddress=document.getElementById("imageaddress").value;
	addtitle=document.getElementById("addtitle").value;
	addRightarticle=document.getElementById("addRightarticle").value;
	addleftarticle=document.getElementById("addleftarticle").value;
	
	$.post('https://nxo-newspaper/savenewspaper', JSON.stringify({imageaddress: imageaddress ,addtitle:addtitle,addRightarticle:addRightarticle,addleftarticle:addleftarticle}));
}