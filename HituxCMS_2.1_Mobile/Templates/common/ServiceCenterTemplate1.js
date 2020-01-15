document.writeln("<div class=\'HituxSer\' style=\'top:$web_top$px;\'>");
document.writeln("  <div class=\'HituxSer_tab\'>");
document.writeln("    <div class=\'icon_HituxSer\'></div>");
document.writeln("    <div class=\'HituxSer_box\'>");
document.writeln("      <div class=\'HituxSer_head\'><a href=\'javascript:void(0)\' class=\'HituxSer_close\'></a></div>");
document.writeln("      <ul class=\'HituxSer_con\'>");
document.writeln("    ");
$web_qqs$
$web_wangwang$
$web_Skypes$
$web_MSNs$
document.writeln("");
document.writeln("     ");
document.writeln("        ");
document.writeln("      </ul>");
document.writeln("      <div class=\'HituxSer_bot\'>");
document.writeln("      </div>");
document.writeln("    </div>");
document.writeln("  </div>");
document.writeln("</div>");
document.writeln("");



$(function(){
	var KF = $(".HituxSer");
	var wkbox = $(".HituxSer_box");
	var kf_close = $(".HituxSer .HituxSer_close");
	var icon_HituxSer = $(".icon_HituxSer");
	var kH = wkbox.height();
	var kW = wkbox.width();
	var wH = $(window).height();
	KF.css({height:kH});
	var KF_top = (wH-kH)/2;
	if(KF_top<0) KF_top=0;
	$(kf_close).click(function(){
		KF.animate({width:"0"},200,function(){
			wkbox.hide();
			icon_HituxSer.show();
			KF.animate({width:26},300);		
		});	
	});
	$(icon_HituxSer).click(function(){
			$(this).hide();
			wkbox.show();
			KF.animate({width:kW},200);
	});
});
