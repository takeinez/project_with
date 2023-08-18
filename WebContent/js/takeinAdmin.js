/**
 * 
 */
	var	catgTexts = [];
	var catgStatus = [];
	var hashMapcatgTexts = {};
	var hashMapcatgStatus = {};
$(function() {
			
	$(".with-admin-menu").click( function() { //메뉴중 클릭시 페이지 전환
    	 let title = $(this).text().replace(/\s+/g, "_");
    	 $(".left_menu").css("display", "none");
    	 $("#" + title).css("display", "inline");
    	 $(".with-admin-menu").removeClass( 'on' );
    	 $(this).addClass('on');
    	 
      });
	
	  
	

	$("#excelRegistration").click( function() { //조직도-부서일괄등록
    	 let title = $(this).text().replace(/\s+/g, "_");
    	 $(".left_menu").css("display", "none");
    	 $("#" + title).css("display", "inline");
      });
      
	$("#returnOrgMainBtn").click( function() { //조직도-부서일괄등록 뒤로가기(조직도 관리 페이지로 이동)
    	 $("#부서_일괄_등록").css("display", "none");
    	 $("#조직도_관리").css("display", "inline");
      });
      
      $("#activeOrgButton").click( function() {
    	  if(disabled==0){
	        $( "#disabledOrgArea" ).addClass( 'able' );
	        $( "#excelRegistration" ).addClass( 'color-change1' );
	        $( "#excelRegistration" ).removeClass( 'bgblue2' );
	        $( "#excelRegistration" ).removeAttr( "disabled", true );
	        $( "#orgChartUseText" ).text( "사용");

			company_use_department(1);
	        
	        if(!($("#orgChartTree .tui-tree-node").hasClass("tui-tree-node"))){ //이미 하나라도 있으면 안뜨게.
	        $("#orgChartNoneData").css('display','flex');
    	    }
	        $("#orgChartTree").css('display','block');
	        disabled+=1;
    	  }
    	  else{
	        $( "#disabledOrgArea" ).removeClass( 'able' );
	        $( "#excelRegistration" ).addClass( 'bgblue2' );
	        $( "#excelRegistration" ).removeClass( 'color-change1' );
	        $( "#excelRegistration" ).attr( "disabled", true );
	        $( "#orgChartUseText" ).text( "비활성");
			company_use_department(0);
	        disabled-=1;

    	  }

      });

});
		
	
function closePop(){
	var b2 = document.getElementById('pop1');
	b2.style.display = 'none';
}
function openPop(){
	var b2 = document.getElementById('pop1');
	b2.style.display = 'block';
}

function moment(){
	var c = document.getElementById('layerAlert');
	 c.style.display = 'flex';  
	 setTimeout("moment2();",2000);    
}
function moment2(){
	var c = document.getElementById('layerAlert');
	 c.style.display = 'none';  
}

 $(function() {
    //모든 datepicker에 대한 공통 옵션 설정
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true //콤보박스에서 년 선택 가능
        ,changeMonth: true //콤보박스에서 월 선택 가능                
        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
    });

    //input을 datepicker로 선언
    $("#a").datepicker();                    
    $("#b").datepicker();
    $("#DOWN_SCHD_STTG_DT").datepicker();
    $("#DOWN_SCHD_FNSH_DT").datepicker();
    
    //From의 초기값을 오늘 날짜로 설정
    $('#DOWN_SCHD_STTG_DT').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    //To의 초기값을 내일로 설정
    $('#DOWN_SCHD_FNSH_DT').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

    
    
    $("#EDIT_LOG_SCHD_STTG_DT").datepicker();
    $("#EDIT_LOG_SCHD_FNSH_DT").datepicker();
	$("#datepicker6").datepicker();
    $('#EDIT_LOG_SCHD_STTG_DT').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    $('#EDIT_LOG_SCHD_FNSH_DT').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
});

$(function(){
											
	$(document).on("click", ".tui-tree-content-wrapper", function(event) {
	    event.stopPropagation(); // 이벤트 전파 방지
	    $(".tui-tree-node").removeClass('tui-selected');
	    $(this).closest(".tui-tree-content-wrapper").parent().addClass('tui-selected');
	});

	$(document).on("click", ".tui-tree-node > .tui-tree-subtree > .tui-tree-node", function(event) {
	    event.stopPropagation(); // 이벤트 전파 방지
	});

	$(document).on("click", ".tui-tree-node", function(event) {
	    if (!$(this).hasClass('tui-selected')) {
	        event.stopPropagation(); // tui-selected 클래스가 없는 경우에만 이벤트 전파 방지
	    }
	});
	
	
	//조직도 부서명 수정 버튼
	$("#treeEditBtn").click(function(){
		if($("#orgChartTree").find(".tui-selected").length>0){
			
			var tex = $(".tui-selected").children("div").children("span").text();
			
			$(".tui-selected").children("div").html(
			"	<input id='newDepartment' kkk='a' class='newInput' type='text' value='"+tex+"' style='border:1px solid;'/>"
			);
		}
		
		$("#newDepartment").on("keydown", function(key) {
            if (key.keyCode == 13) {
                $("#newDepartment").each(function(index) {
			      let department_name = $(this).val();
				  let department_id = $(this).parent().parent().attr("department_id");
				  department_correction(department_id, department_name, tex);
			     
			      $(this).parent().html("<span class='tui-tree-text tui-js-tree-text'>"+department_name+"</span>");

				  department_load();
					
					
			      
			    });
				
				
				
				
                
            }
        });
		
	});
	
	//조직도 부서 추가버튼
	$("#treeAddBtn").click(function(){
	if($("#newDepartment").length==1) {
	} else {
		
	if($("#orgChartTree").find(".tui-selected").length>0&&$(".tui-selected").find(".tui-tree-subtree").length==0){											
//		alert("있따");
		$(".tui-selected").append(
		"		<ul class='tui-tree-subtree tui-js-tree-subtree'> " +
		"			<li id='dvsn-3' class='tui-tree-node tui-tree-leaf'> " +
		"	        	<div class='tui-tree-content-wrapper' style='padding-left: 23px'> " +
		"	            	<input id='newDepartment' class='newInput' type='text' style='border:1px solid;'/> " +
		"	        	</div> " +
		"	    	</li> " +
		"	    </ul> " 
		);
	}
	else if($("#orgChartTree").find(".tui-selected").length>0&&$(".tui-selected").find(".tui-tree-subtree").length>0){
//		alert("있따2");
			$('.tui-selected>.tui-tree-subtree').append(
		"	<li id='dvsn-1' class='tui-tree-node'> " +
		"        <div class='tui-tree-content-wrapper' style='padding-left: 23px'> " +
		"            <input id='newDepartment' class='newInput' type='text' style='border:1px solid;'/> " +
		"        </div> " +
		"    </li>"
		);
	}
		
	else{
		
		$("#orgChartNoneData").css('display','none');
		$("#orgChartTree .tui-tree").append(
				
		"	<li id='dvsn-1' class='tui-tree-node'> " +
		"        <div class='tui-tree-content-wrapper' style='padding-left: 23px'> " +
		"            <input id='newDepartment' class='newInput' type='text' style='border:1px solid;'/> " +
		"        </div> " +
		"    </li>"
		);
	}
		
		$("#newDepartment").on("keydown", function(key) {
            if (key.keyCode == 13) {
	            $(".tui-tree-node").removeClass( 'tui-tree-last' );
	 	    	$(this).parent().parent().addClass('tui-tree-last');
				

				$("#newDepartment").each(function(index) {
			      let department_name = $(this).val();
				  let up_department_id = $(this).parent().parent().parent().parent().attr("department_id");
				  if(up_department_id==null) {
					up_department_id = 0;
				  }
				  let exposure_procedure = $(this).parent().parent().parent().parent().attr("exposure_procedure");
				  if(exposure_procedure==null) {
					exposure_procedure = 0;
				  }
		
			      department_add(department_name, up_department_id, exposure_procedure);

			      $(this).parent().html("<span class='tui-tree-text tui-js-tree-text'>"+department_name+"</span>");
			      
			    });

				setTimeout(function() {
			          department_load();
				}, 50);
                
            }
        });
		$('html').off().one("click", function(e) {
            if (!$(e.target).hasClass("newInput")) {
                $(".newInput").parent().parent().remove();
            }
        }).one("click", "#treeAddBtn", function(e) {
            e.stopPropagation(); // 버튼 클릭시 영역 밖 alert를 방지하기 위해 이벤트 전파 중지
        });


		}
		
	});
	
	//조직도삭제버튼
	$(document).on("click", "#treeRemoveBtn", function(event) {
		if($(".tui-selected").length == 0) {
			
		} else {
			if(confirm("정말 삭제하시겠습니까?")) {
				let department_id = $(".tui-selected").attr("department_id");
				let department_name = $(".tui-selected div span").text();
				department_delete(department_id, department_name);
				if($("#orgChartTree").find(".tui-selected").length>0){
				if($(".tui-selected").parent().parent().children("ul").find(".tui-tree-node").length==1){
					$(".tui-selected").parent().parent().children("div").find(".tui-tree-toggle-btn").remove();
				}
				$(".tui-selected").remove();
				}
			}
			setTimeout(function() {
			          department_load();
			}, 50);
//			$("#orgChartTree .tui-tree.tui-tree-root li").each(function() {
//				if($(this).find("ul").find().length==0) {
//					alert($(this).find("ul").find().length);
//					alert($(this).children(".tui-tree-content-wrapper").children(".tui-js-tree-text").text());
//				} else {
//					alert("@");
//				}
//			});
		}
	});
	let i = 1;
	
	$(document).ready(function() {
		
		//Depth에 따른 패딩 크기
	    $(".tui-tree-node").each(function() {
		    var parents = $(this).parents('.tui-tree-node');
			var pad = (parents.length)*23+23;
		    $(this).children("div").css("padding-left",pad+"px");
		    console.log("부모 개수: " + parents.length);
		  });
		
		
		  // 페이지 로드 시 초기 상태를 판단하여 버튼 생성 또는 제거
		  $(".tui-tree-node").each(function() {
		    if ($(this).find(".tui-tree-subtree").length > 0 && $(this).children("div").find(".tui-tree-toggle-btn").length === 0) {
		      $(this).children("div").prepend(
		    		  "		<button type='button' class='tui-tree-toggle-btn tui-js-tree-toggle-btn'> " + 
				    	"		<span class='tui-ico-tree'></span> " +
				        "        </button> "
		      );
		    } else if ($(this).find(".tui-tree-subtree").length === 0) {
		      $(this).children("div").find(".tui-tree-toggle-btn").remove();
		    }
		    
		    if($(this).find(".tui-tree-subtree").length>0){
		    	$(this).addClass("tui-tree-opened");
		    }
		  });

		 
		});
	
	  // 동적으로 요소가 변경될 때 버튼 생성 또는 제거
	  $(document).on("change", ".tui-tree-node", function() {
	    if ($(this).find(".tui-tree-subtree").length > 0 && $(this).children("div").find(".tui-tree-toggle-btn").length === 0) {
	    	
	    	$(this).children("div").prepend(
	    	"		<button type='button' class='tui-tree-toggle-btn tui-js-tree-toggle-btn'> " + 
	    	"		<span class='tui-ico-tree'></span> " +
	        "        </button> "
	    	);
	    }
	    if($(this).find(".tui-tree-subtree").length>0){
	    	$(this).addClass("tui-tree-opened");
	    }
	    //Depth에 따른 패딩 크기
	    $(".tui-tree-node").each(function() {
		    var parents = $(this).parents('.tui-tree-node');
			var pad = (parents.length)*23+23;
		    $(this).children("div").css("padding-left",pad+"px");
		    console.log("부모 개수: " + parents.length);
		    
		    if($(this).find(".tui-tree-subtree").length>0){
		    	$(this).removeClass("tui-tree-leaf");
		    }
		    else if($(this).find(".tui-tree-subtree").length==0){
		    	$(this).addClass("tui-tree-leaf");
		    }
		    
		  });
	    
	  });
	  
	  // 동적으로 버튼 눌려씅떄
	  $(document).on("click",".tui-tree-toggle-btn", function(){
		  if($(this).parent().parent().hasClass("tui-tree-opened")){
			  $(this).parent().parent().removeClass("tui-tree-opened");
			  $(this).parent().parent().addClass("tui-tree-closed");
			  $(this).parent().parent().children(".tui-tree-subtree").hide();
		  }
		  else{
			  $(this).parent().parent().removeClass("tui-tree-closed");
			  $(this).parent().parent().addClass("tui-tree-opened");
			  $(this).parent().parent().children(".tui-tree-subtree").show();
		  }
		  
	  });
	  
	  
	  //초기화 버튼 누르면
	  $(document).on("click","#departmentReset",function(){
		 $(".tui-tree").html(""); 
	  });

});


$(function() {
	
	  let ea = 0;
	 
	  $("#open_catg_edit_bt").click(function() {
	    $("#open_catg_save_bt").css('display', 'inline-block');
	    $("#open_catg_cancel_bt").css('display', 'inline-block');
	    $("#open_catg_edit_bt").css('display', 'none');
	    $("#open_catg_add_bt").css('display', 'inline-block');
	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .delete_bt").css('display', 'inline-block');
		ea = 0;
		
	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .catg_td").each(function(index) {
	      let currentValue = $(this).text();
	      catgTexts.push(currentValue);
		  hashMapcatgTexts[$(this).parent().attr("category_id")] = currentValue;
	      ea+=1;
	      $(this).html("<input maxlength='20' style='height: 25px; width: 400px; margin-left: 15px' class='catg_input' value='" + currentValue + "'>");
	    });
	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .use_yn").each(function(index){
	    	let cv = $(this).text();
	    	catgStatus.push(cv);
			if(cv == "활성") {
				hashMapcatgStatus[$(this).parent().attr("category_id")] = 1;		
			} else if(cv == "비활성") {
				hashMapcatgStatus[$(this).parent().attr("category_id")] = 0;				
			}
	    	if(cv=='활성'){
	    		$(this).html("<select style='cursor:pointer; margin-left:15px'><option value='Y' selected>ON</option><option value='N'>OFF</option></select>");
	    	}else{
	    		$(this).html("<select style='cursor:pointer; margin-left:15px'><option value='Y'>ON</option><option value='N' selected>OFF</option></select>");
	    	}
	    });

	  });

//	  $("#open_catg_save_bt").click(function() {
//	    $("#open_catg_save_bt").css('display', 'none');
//	    $("#open_catg_cancel_bt").css('display', 'none');
//	    $("#open_catg_edit_bt").css('display', 'inline-block');
//	    $("#open_catg_add_bt").css('display', 'none');
//	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .delete_bt").css('display', 'none');
//	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .btn_drag").css('display', 'none');
//
//	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .catg_td input.catg_input").each(function(index) {
//	      let inputValue = $(this).val();
//	     
//	      $(this).parent().html(inputValue);
//	    });
//	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .use_yn select").each(function(index){
//	    	let inputSelect = $(this).val();
//	    	
//	    	if(inputSelect=='Y'){
//	    	$(this).parent().html('활성');
//	    	}else{
//	    	$(this).parent().html('비활성');
//	    	}
//	    });
//	    
//    	$( "#공개_프로젝트_카테고리 .list_table #open_catg_tbody .add_stts" ).removeClass( 'add_stts' );
//	    
//	    $("#open_catg_tbody>:hidden").remove();
//	    
//	  });
		
	  let beforeRemoveCatg =[];
	  $(document).on("click", ".delete_bt",function() {
		  $(this).parent().parent().hide();
	  });	
	  
	  $("#open_catg_cancel_bt").click(function() {
	    $("#open_catg_save_bt").css('display', 'none');
	    $("#open_catg_cancel_bt").css('display', 'none');
	    $("#open_catg_edit_bt").css('display', 'inline-block');
	    $("#open_catg_add_bt").css('display', 'none');
	    $("#open_catg_tbody .delete_bt").css('display', 'none');
		$("")
		
	    $("#open_catg_tbody .add_stts").each(function(index) {
	    	$("#open_catg_tbody>.add_stts").remove(); //취소전 추가하려했던 요소 삭제
		});
	    
	 // 입력한 값을 초기화하고 원래의 값으로 되돌리기
	    $("#open_catg_tbody .catg_td").each(function(index) {
	      let originalValue = catgTexts[index]; 
	      $(this).html(originalValue);
	    });
	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .use_yn").each(function(index) {
	      let originalSelect = catgStatus[index];
	      $(this).html(originalSelect);
	    });
	    
	    $("#open_catg_tbody>:hidden").show(); //삭제하려다 만거
	    
	  });
	  
	  $("#open_catg_add_bt").click(function() { //카테고리 추가 할 때.
		  $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody").append(
		   " <tr class='add_stts'> " +
		   "   <td class='drag_bt'> " +
		   "   </td> " +
		   "   <td class='catg_td'> " +
		   "     <input maxlength='20' style='height:25px; width:400px; margin-left:15px' class='catg_input' placeholder='카테고리명을 입력해주세요' required > " +
		   "   </td> " +
		   "   <td> " +
		   "     <span style='margin-left:15px'>0</span> " +
		   "   </td> " +
		   "   <td class='use_yn'> " +
		   "     <select style='cursor:pointer; margin-left:15px'> " +
		   "       <option value='Y'>ON</option> " +
		   "       <option value='N'>OFF</option> " +
		   "     </select> " +
		   "   </td> " +
		   "   <td> " +
		   "     <span style='cursor:pointer; color:red; margin-left:15px; margin-right:15px' class='delete_bt btn btn_style1'>삭제</span> " +
		   "   </td> " +
		   " </tr> "
		  );
	  	  
		  var trElements = document.querySelectorAll("tr[data]");
		  var newArray = [];

		  for (var i = 0; i < trElements.length; i++) {
		    var dataValue = trElements[i].getAttribute("data");
		    newArray.push(dataValue);
		  }
		  var max = Math.max.apply(null, newArray);
		  
		  $("#open_catg_tbody .add_stts").attr("data",max+1);
	  
	  
	  
		});
	  
	    
	});






























