<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String id = "alone";
	String pw = "1234";
	String first_name = "Steven";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css">
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/42669b0565.js" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>

<link href="css/wid.css" rel="stylesheet">

<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGqbkrXZ42f8TtH3Sv6Uu4edzDm3EvCoM&libraries=places"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="js/hereAjax.js"></script>
<script src="js/googlemap.js"></script>
<%
    String countSql = "SELECT process, COUNT(*) FROM BOARD_WORK GROUP BY process";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int a = 0, b = 0, c = 0, d = 0, e = 0;

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, id, pw);
        pstmt = conn.prepareStatement(countSql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String process = rs.getString(1);
            int count = rs.getInt(2);

            if ("요청".equals(process)) {
                a = count;
            } else if ("진행".equals(process)) {
                b = count;
            } else if ("피드백".equals(process)) {
                c = count;
            } else if ("완료".equals(process)) {
                d = count;
            } else if ("보류".equals(process)) {
                e = count;
            }
        }

    } catch (ClassNotFoundException | SQLException ex) {
        ex.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }

    int sum = a + b + c + d + e;
%>
<script>
var nowId = "wjdxortl16@gmail.com";
$.datepicker.setDefaults({
	  dateFormat: 'yy-mm-dd',
	  prevText: '이전 달',
	  nextText: '다음 달',
	  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	  showMonthAfterYear: true,
	  yearSuffix: '년'
	});

	$(function () {
	  $("#datepicker1, #datepicker2, #datepicker3, #datepicker4,#datepicker5,#datepicker6,#datepicker7,.js-pickr-text").datepicker();
	$("#datepicker8").datepicker({
	    dateFormat: "yy-mm-dd (DD) 까지",
	    dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"]
	});
	});
  </script>
<script>
	$(document).ready(function() {
	    var $layer = $('#searchPopupLayer');
	    var $content = $('#searchPopupContent');
	    $('#searchPopupTopButton').click(function() {
	        $layer.fadeIn('fast');
	    });
	    $(document).mouseup(function(e) { 
	    	   var $datePickerDiv = $("#ui-datepicker-div");
	           if (!$layer.is(e.target) && !$layer.has(e.target).length &&
	              !$datePickerDiv.is(e.target) && !$datePickerDiv.has(e.target).length) {
	               $layer.fadeOut('fast');
	           }
	       });
	    });
</script>
<script>
function showTooltip() {
    document.getElementById('tooltipArea').style.display = 'block';
  }

  function hideTooltip() {
    document.getElementById('tooltipArea').style.display = 'none';
  }
  
  document.addEventListener("DOMContentLoaded", function() {
    const sections = document.querySelectorAll(".js-search-section");

    sections.forEach(function(section) {
      section.addEventListener("click", function(e) {
        e.preventDefault();
        const dataCode = this.dataset.code;
        const addButton = document.querySelector(".js-add-section");

        addButton.setAttribute("data-code", dataCode);
        updateDisplay(); 
      });
      const resetButtons = document.querySelectorAll(".js-filter-reset.condition-reset");
      
      resetButtons.forEach(function(button) {
        button.addEventListener("click", function() {
          const addButton = document.querySelector(".js-add-section");
          addButton.setAttribute("data-code", "none");
          updateDisplay(); 
        });
      });
    });
  });


  
  function updateDisplay() {
    const addButton = document.querySelector(".js-add-section");
    const dataCode = addButton.getAttribute("data-code");
    const displayValue = dataCode === "project" ? "block" : "none";
    const displayValue1 = dataCode === "post" ? "block" : "none";
    const displayValue2 = dataCode === "none" ? "block" : "none";
    
    switch(dataCode){
    case "project" :
    document.querySelector(".js-search-section-div").style.display = displayValue === "block" ? "none" : "block";
    document.getElementById("detailSearchArea").style.display = displayValue;
    document.querySelector(".js-period-type-search-filter").style.display = displayValue === "block" ? "none" : "block";
    document.querySelector(".js-participant-name-search-filter").style.display = displayValue;
    document.querySelector(".js-tmpl-type-search-filter").style.display = displayValue === "block" ? "none" : "block";
    case "post" :
    document.querySelector(".js-search-section-div").style.display = displayValue1 === "block" ? "none" : "block";
    document.getElementById("detailSearchArea").style.display = displayValue1;    
    document.querySelector(".js-project-name-search-filter").style.display = displayValue1;
    document.querySelector(".js-register-name-search-filter").style.display = displayValue1;
    document.querySelector(".js-participant-name-search-filter").style.display = displayValue1 === "block" ? "none" : "block";
    document.querySelector(".js-period-type-search-filter").style.display = displayValue1; 
    document.querySelector(".js-tmpl-type-search-filter").style.display = displayValue1; 
    case "none" :
    document.querySelector(".js-search-section-div").style.display = displayValue2;
    document.getElementById("detailSearchArea").style.display = displayValue2 === "block" ? "none" : "block";
    
    }
  }
  
  document.addEventListener('DOMContentLoaded', () => {
	    const periodTypes = document.querySelectorAll('.js-period-type');
	    const calendarElements = document.querySelectorAll('.js-search-pickr-layer');

	    periodTypes.forEach((element) => {
	        element.addEventListener('click', (event) => {
	            const dataCode = event.currentTarget.getAttribute('data-code');
	            const liElements = document.querySelectorAll('.js-period-type-search-filter');

	            liElements.forEach((liElement) => {
	                liElement.setAttribute('data-code', dataCode);
	            });

	            calendarElements.forEach((calendarElement) => {
	                if (dataCode === 'select') {
	                    calendarElement.style.display = 'block';
	                } else {
	                    calendarElement.style.display = 'none';
	                }
	            });
	        });
	    });
	});
	function openPopup() {	
		if(document.getElementById('organizationLayer').style.display === 'none'){
		 document.getElementById('organizationLayer').style.display = 'block';
		 document.getElementById('chattingLayer').style.display = 'none';
		 document.getElementById('alarmLayer').style.display = 'none';
		 document.getElementById('accountLayer').style.display = 'none';
		}else{
		 document.getElementById('organizationLayer').style.display = 'none';			
			}		
		}
	function openPopup1() {
		if(document.getElementById('chattingLayer').style.display === 'none'){
		 document.getElementById('chattingLayer').style.display = 'block';
		 document.getElementById('organizationLayer').style.display = 'none';
		 document.getElementById('alarmLayer').style.display = 'none';
		 document.getElementById('accountLayer').style.display = 'none';
		}else{
		 document.getElementById('chattingLayer').style.display = 'none';			
			}		
		}
	function openPopup2() {
		if(document.getElementById('plus').style.display === 'none'){
			document.getElementById('plus').style.display = 'inline-grid';
			document.getElementById('plus').style.position = 'absolute';
		}else{
			document.getElementById('plus').style.display= 'none';			
			}		
		}
	function openMenu(selectedMenuId, menuIds, selectedItemId, itemIds) {
	    menuIds.forEach(menuId => {
	        var menuElement = document.getElementById(menuId);
	        if (menuId === selectedMenuId) {
	            menuElement.style.display = 'inline';
	        } else {
	            menuElement.style.display = 'none';
	        }
	    });

	    itemIds.forEach(itemId => {
	        var itemElement = document.getElementById(itemId);
	        if (itemId === selectedItemId) {
	            itemElement.style.display = 'none';
	        } else {
	            itemElement.style.display = 'block';
	        }
	    });
	    document.getElementById('menu1').classList.add('with-active');
	}

	function openPopup3() {
	    openMenu('menu1', ['menu1', 'menu2', 'menu3', 'menu4'], 'item1', ['item1', 'item2', 'item3', 'item4']);
	}

	function openPopup4() {
	    openMenu('menu2', ['menu1', 'menu2', 'menu3', 'menu4'], 'item2', ['item1', 'item2', 'item3', 'item4']);
	}

	function openPopup5() {
	    openMenu('menu3', ['menu1', 'menu2', 'menu3', 'menu4'], 'item3', ['item1', 'item2', 'item3', 'item4']);
	}

	function openPopup6() {
	    openMenu('menu4', ['menu1', 'menu2', 'menu3', 'menu4'], 'item4', ['item1', 'item2', 'item3', 'item4']);
	}
	function openPopup7() {
	    var menu11 = $("#menu11");
	    
	    menu11.toggle("1000", function() {
	        if(menu11.css("display") !== "none") {
	            menu11.css("display", "inline");
	        }
	    });
	}
	function openPopup8() {
	    var menu11 = $("#RecentProjectUl");
	    
	    menu11.toggle("1000", function() {
	        if(menu11.css("display") !== "none") {
	            menu11.css("display", "inline");
	        }
	    });
	}
	function openPopup14() {
	    var menu11 = $("#allLabelUl");
	    
	    menu11.toggle(function() {
	        if(menu11.css("display") !== "none") {
	            menu11.css("display", "inline");
	        }
	    });
	}
	function openPopup11() {
		$("#accountLayer").toggle("500",function(){
			if($("#accountLayer").css("display") !== "none"){
				$("#accountLayer").css("display", "grid");
			}
		});	
	}
	function openPopup12(){
		$("#tempPopup").toggle("500",function(){
			if($("#tempPopup").css("display") !== "none"){
				$("#tempPopup").css("display", "block");
				$("#accountLayer").css("display", "none");
			}
		});	
	}
	function openPopup13(){
		$("#mySettingPopup").toggle("500",function(){
			if($("#mySettingPopup").css("display") !== "none"){
				$("#mySettingPopup").css("display", "block");
				$("#accountLayer").css("display", "none");
			}
		});	
	}
	
	function closePopup1() {		
	$("#searchPopupLayer").hide(); 
	}
	function openPopup9() {
		if(document.getElementById('alarmLayer').style.display === 'none'){
		 document.getElementById('alarmLayer').style.display = 'block';
		 document.getElementById('chattingLayer').style.display = 'none';
		 document.getElementById('organizationLayer').style.display = 'none';
		 document.getElementById('accountLayer').style.display = 'none';
		}else{
		 document.getElementById('alarmLayer').style.display = 'none';			
			}		
		}

	$(document).ready(function () {
	    // 클릭 이벤트 함수를 정의
	    var handleElementClick = function () {
	        // 클릭한 요소의 하위에 있는 a 태그를 복사합니다.
	        var aClone = $(this).find('a').clone();

	        // 클릭한 aClone 요소에 클릭 이벤트 핸들러를 추가합니다.
	        aClone.on('click', function (e) {
	            e.preventDefault(); // 기본 a 태그 클릭 작동 방지
	            // 클릭된 a 요소를 삭제합니다.
	            $(this).remove();
	            document.querySelector(".js-search-section-div").style.display = "block";
	            document.getElementById("detailSearchArea").style.display = "none";
	        });

	        // 복사한 a 요소를 #searchPopupInputWrapper에 삽입
	        $('#searchPopupInputWrapper').prepend(aClone);
	    };

	    // 입력 이벤트 함수를 정의
	    var handleInputKeyUp = function() {
	        // 입력값을 가져와 cursor-pointer js-main-search-box-placeholder 클래스의 텍스트로 설정합니다.
	        $('.cursor-pointer.js-main-search-box-placeholder').text($(this).val());
	    };

	    // js-filter-reset.condition-reset을 클릭하면 aClone 요소가 삭제되게 합니다.
	    var handleConditionResetClick = function() {
	        $("#searchPopupInputWrapper").find("a:first").remove();
	    };

	    // 프로젝트, 글, 댓글 요소에 클릭 이벤트 처리를 추가합니다.
	    $('li[data-code="project"], li[data-code="post"], li[data-code="comment"]').click(handleElementClick);
	
	    // searchPopupInput 요소에 입력 이벤트 처리를 추가합니다.
	    $('#searchPopupInput').on('keyup', handleInputKeyUp);

	    // js-filter-reset.condition-reset 요소에 클릭 이벤트 처리를 추가합니다.
	    $('.js-filter-reset.condition-reset').on('click', handleConditionResetClick);
	});
	

	 function openPopup10() {
	 $("#alarmSearchFilterLayer").toggle(); // show -> hide , hide -> show
			}
	 
	 function changeClass() {
		  const divElement = document.querySelector('.js-project-title.js-filter-item.setup-detail-type-1');
		  divElement.classList.toggle('setup-active-type-1')
		}
	 function changeClass1() {
		  const divElement = document.querySelector('.js-contents.js-filter-item.setup-detail-type-1');
		  divElement.classList.toggle('setup-active-type-1')
		}
	 function changeClass2() {
		  const divElement = document.querySelector('.js-register-id.js-filter-item.setup-detail-type-1');
		  divElement.classList.toggle('setup-active-type-1')
		}
	 
	 
	 
	 $(document).ready(function () {
		  $('#accountSettingBtn').click(function (e) {
		    e.preventDefault();
		    showLayer('#accountSettingLayer');
		    updateSettingBtnStyle(this, 'my-color-type-1', 'my-type-text-1', 'my-color-type-2', 'my-type-text-2');
		  });

		  $('#preferencesBtn').click(function (e) {
		    e.preventDefault();
		    showLayer('#preferencesLayer');
		    updateSettingBtnStyle(this, 'my-color-type-1', 'my-type-text-1', 'my-color-type-2', 'my-type-text-2');
		  });

		  $('#deviceManagementBtn').click(function (e) {
		    e.preventDefault();
		    showLayer('#deviceManagementLayer');
		    updateSettingBtnStyle(this, 'my-color-type-1', 'my-type-text-1', 'my-color-type-2', 'my-type-text-2');
		  });

		  $('#projectSettingBtn').click(function (e) {
		    e.preventDefault();
		    showLayer('#projectSettingsLayer');
		    updateSettingBtnStyle(this, 'my-color-type-1', 'my-type-text-1', 'my-color-type-2', 'my-type-text-2');
		  });

		  function showLayer(layerSelector) {
		    $('.js-my-scroll-layer').addClass('d-none');
		    $(layerSelector).removeClass('d-none').addClass('d-block');
		  }

		  function updateSettingBtnStyle(element, class1, class1Text, class2, class2Text) {
		    $('.js-my-setting-left a em.my-color-type-2').removeClass(class2).addClass(class1);
		    $('.js-my-setting-left a em.my-type-text-2').removeClass(class2Text).addClass(class1Text);

		    $(element).children('em').each(function () {
		      if ($(this).hasClass(class1)) {
		        $(this).removeClass(class1).addClass(class2);
		      } else if ($(this).hasClass(class1Text)) {
		        $(this).removeClass(class1Text).addClass(class2Text);
		      }
		    });

		  }
		});
		  
		  
	 document.addEventListener("DOMContentLoaded", function() {
		    const changeEditorBtn = document.querySelector('.change-editor-btn');
		    const cancelChange = document.querySelector('.cancel-change');
		    const changeOk = document.querySelector('.change-ok');
		    const readMode = document.querySelector('.read-mode');
		    const editorMode = document.querySelector('.editor-mode');
		    const userNames = document.querySelectorAll('.js-user-name');
		    const editorUserName = document.getElementById('editor_user_name');

		    function validateInput(inputElement) {
		        const inputValue = inputElement.value.trim();
		        const regex = new RegExp(/[a-zA-Z0-9가-힣ㄱ-ㅎ\s]+$/); // 특수 문자를 제외한 문자와 한글 Only
		        const errorMessage = document.getElementById("error-message");

		        errorMessage.style.display = "none";

		        if (inputValue.length == 0) { // 데이터가 비어 있는 경우
		          errorMessage.textContent = inputElement.dataset.emptyMsg;
		          errorMessage.style.display = "block";
		          return false;
		        } else if (inputValue.length > 20) { // 데이터 길이가 20을 초과하는 경우
		          errorMessage.textContent = inputElement.dataset.overMsg;
		          errorMessage.style.display = "block";
		          return false;
		        } else if (inputValue.length > 0 && !regex.test(inputValue)) { // 입력 값이 비어있지 않으면서 특수 문자를 포함하는 경우
		          errorMessage.textContent = inputElement.dataset.unValidMsg;
		          errorMessage.style.display = "block";
		          return false;
		        }

		        return true;
		      }
		    
		    changeEditorBtn.addEventListener('click', (e) => {
		        e.preventDefault();
		        readMode.classList.remove('d-block');
		        readMode.classList.add('d-none');
		        editorMode.classList.remove('d-none');
		        editorMode.classList.add('d-block');
		        editorUserName.value = userNames[0].textContent;
		    });
		    cancelChange.addEventListener('click', (e) => {
		        e.preventDefault();
		        readMode.classList.remove('d-none');
		        readMode.classList.add('d-block');
		        editorMode.classList.remove('d-block');
		        editorMode.classList.add('d-none');
		    });

		    changeOk.addEventListener("click", (e) => {
		        e.preventDefault();
		        if (validateInput(editorUserName)) { // 입력 값이 올바른 경우에만 저장
		          userNames.forEach((userName) => {
		            userName.textContent = editorUserName.value.trim();
		          });
		          readMode.classList.remove("d-none");
		          readMode.classList.add("d-block");
		          editorMode.classList.remove("d-block");
		          editorMode.classList.add("d-none");
		        }
		      });
		    });
	 
	 document.addEventListener("DOMContentLoaded", function () {
		  const changeEditorPositionBtn = document.querySelector(".change-editor-position-btn");
		  const cancelPositionChange = document.querySelector(".cancel-position-change");
		  const changePositionOk = document.querySelector(".change-position-ok");
		  const readModePosition = document.querySelector("#settingJbcl .read-mode");
		  const editorModePosition = document.querySelector("#settingJbcl .editor-mode");
		  const position = document.querySelector(".js-position-name");
		  const editorPosition = document.getElementById("editor_position");

		  
		  changeEditorPositionBtn.addEventListener("click", (e) => {
		    e.preventDefault();
		    readModePosition.classList.remove("d-block");
		    readModePosition.classList.add("d-none");
		    editorModePosition.classList.remove("d-none");
		    editorModePosition.classList.add("d-block");
		    editorPosition.value = position.textContent;
		  });

		  cancelPositionChange.addEventListener("click", (e) => {
		    e.preventDefault();
		    readModePosition.classList.remove("d-none");
		    readModePosition.classList.add("d-block");
		    editorModePosition.classList.remove("d-block");
		    editorModePosition.classList.add("d-none");
		  });

		  changePositionOk.addEventListener("click", (e) => {
		    e.preventDefault();
		      position.textContent = editorPosition.value.trim();
		      readModePosition.classList.remove("d-none");
		      readModePosition.classList.add("d-block");
		      editorModePosition.classList.remove("d-block");
		      editorModePosition.classList.add("d-none");
		  });
		});
	 
	 document.addEventListener("DOMContentLoaded", function () {
		  const changeEditorPositionBtn = document.querySelector("#settingClphNo .change-editor-btn");
		  const cancelPositionChange = document.querySelector("#settingClphNo .cancel-change");
		  const changePositionOk = document.querySelector("#settingClphNo .change-ok");
		  const readModePosition = document.querySelector("#settingClphNo .read-mode");
		  const editorModePosition = document.querySelector("#settingClphNo .editor-mode");
		  const position1 = document.querySelector("#settingClphNo .js-phone-number");
		  const position = document.querySelector("#profileClphNo .profileClphNo");
		  const editorPosition = document.getElementById("editor_phoneNum");

		  function validatePhoneNumberInput(inputElement) {
		    const inputValue = inputElement.value.trim();
		    const regex = new RegExp(/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/);
		    const errorMessage = document.querySelector("#settingClphNo #error-message");

		    errorMessage.style.display = "none";

		    if (inputValue.length > 0 && !regex.test(inputValue)) {
		      errorMessage.textContent = inputElement.dataset.unValidMsg;
		      errorMessage.style.display = "block";
		      return false;
		    }

		    return true;
		  }

		  changeEditorPositionBtn.addEventListener("click", (e) => {
		    e.preventDefault();
		    readModePosition.classList.remove("d-block");
		    readModePosition.classList.add("d-none");
		    editorModePosition.classList.remove("d-none");
		    editorModePosition.classList.add("d-block");
		    editorPosition.value = position.innerHTML;
		    editorPosition.value = position1.textContent;
		  });

		  cancelPositionChange.addEventListener("click", (e) => {
		    e.preventDefault();
		    readModePosition.classList.remove("d-none");
		    readModePosition.classList.add("d-block");
		    editorModePosition.classList.remove("d-block");
		    editorModePosition.classList.add("d-none");
		  });

		  changePositionOk.addEventListener("click", (e) => {
		    e.preventDefault();
		    if (validatePhoneNumberInput(editorPosition)) {
		      position.innerHTML = editorPosition.value.trim();
		      position1.textContent = editorPosition.value.trim();
		      readModePosition.classList.remove("d-none");
		      readModePosition.classList.add("d-block");
		      editorModePosition.classList.remove("d-block");
		      editorModePosition.classList.add("d-none");
		    }
		  });
		});
	 document.addEventListener("DOMContentLoaded", function () {
		  const changeEditorPositionBtn = document.querySelector("#settingCmpnTlphNo .change-editor-btn");
		  const cancelPositionChange = document.querySelector("#settingCmpnTlphNo .cancel-change");
		  const changePositionOk = document.querySelector("#settingCmpnTlphNo .js-account-set-button.my-button-ok.change-ok.second");
		  const readModePosition = document.querySelector("#settingCmpnTlphNo .read-mode");
		  const editorModePosition = document.querySelector("#settingCmpnTlphNo .editor-mode");
		  const position1 = document.querySelector("#settingCmpnTlphNo #companyPhoneNum");
		  const position = document.querySelector("#profileCmpnTlphNo .profileCmpnTlphNo");
		  const editorPosition = document.getElementById("editor_phoneNum1");

		  function validatePhoneNumberInput(inputElement) {
			    const inputValue = inputElement.value.trim();
			    const regex = new RegExp(/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/); // 전화번호 형식
			    const errorMessage = document.querySelector("#settingCmpnTlphNo #error-message1");

			    errorMessage.style.display = "none";

			    if (inputValue.length > 0 && !regex.test(inputValue)) { // 입력 값이 비어있지 않으면서 숫자, +, - 이외의 문자를 포함하는 경우
			      errorMessage.textContent = inputElement.dataset.unValidMsg;
			      errorMessage.style.display = "block";
			      return false;
			    }

			    return true;
			}

		  changeEditorPositionBtn.addEventListener("click", (e) => {
			    e.preventDefault();
			    readModePosition.classList.remove("d-block");
			    readModePosition.classList.add("d-none");
			    editorModePosition.classList.remove("d-none");
			    editorModePosition.classList.add("d-block");
			    editorPosition.value = position.innerHTML;
			    editorPosition.value = position1.textContent;
			  });

			  cancelPositionChange.addEventListener("click", (e) => {
			    e.preventDefault();
			    readModePosition.classList.remove("d-none");
			    readModePosition.classList.add("d-block");
			    editorModePosition.classList.remove("d-block");
			    editorModePosition.classList.add("d-none");
			  });

			  changePositionOk.addEventListener("click", (e) => {
			    e.preventDefault();
			    if (validatePhoneNumberInput(editorPosition)) {
			      position.innerHTML = editorPosition.value.trim();
			      position1.textContent = editorPosition.value.trim();
			      readModePosition.classList.remove("d-none");
			      readModePosition.classList.add("d-block");
			      editorModePosition.classList.remove("d-block");
			      editorModePosition.classList.add("d-none");
			    }
			  });
			});
	 document.addEventListener("DOMContentLoaded", function () {	  
	 const resetPasswordBtn = document.querySelector("#passwordArea .change-editor-btn");
	 const cancelResetPasswordBtn = document.getElementById("changePasswordCancel");
	 const confirmResetPasswordBtn = document.getElementById("changePasswordBtn");
	 const readModePassword = document.querySelector("#passwordArea .read-mode");
	 const editorModePassword = document.querySelector("#passwordArea .editor-mode");
	 const currentPasswordInput = document.getElementById("currentPassword");
	 const newPasswordInput = document.getElementById("myPassword");
	 const confirmPasswordInput = document.getElementById("myPassword2");

	 function validatePasswordInputs() {
	   const passwordPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,20}$/;

	   const isValidNewPassword = passwordPattern.test(newPasswordInput.value);
	   const isValidConfirmPassword = passwordPattern.test(confirmPasswordInput.value);

	   return isValidNewPassword && isValidConfirmPassword;
	 }

	 resetPasswordBtn.addEventListener("click", (e) => {
	   e.preventDefault();
	   readModePassword.classList.remove("d-block");
	   readModePassword.classList.add("d-none");
	   editorModePassword.classList.remove("d-none");
	   editorModePassword.classList.add("d-block");
	 });

	 cancelResetPasswordBtn.addEventListener("click", (e) => {
	   e.preventDefault();
	   readModePassword.classList.remove("d-none");
	   readModePassword.classList.add("d-block");
	   editorModePassword.classList.remove("d-block");
	   editorModePassword.classList.add("d-none");
	 });

	 confirmResetPasswordBtn.addEventListener("click", (e) => {
	   e.preventDefault();

	   if (validatePasswordInputs()) {
	     if (newPasswordInput.value.trim() === confirmPasswordInput.value.trim()) {
	       // 서버로 필요한 정보를 보내서 실제 비밀번호 변경 작업 수행
	       // 서버 측 요청이 성공적으로 완료되면 전환
	       readModePassword.classList.remove("d-none");
	       readModePassword.classList.add("d-block");
	       editorModePassword.classList.remove("d-block");
	       editorModePassword.classList.add("d-none");
	     } else {
	       alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	     }
	   } else {
	     alert("유효하지 않은 입력입니다. 비밀번호는 8~20자의 영문, 숫자, 특수문자를 포함해야 합니다.");
	   }
	 });
	 });
	 
	 
	 document.addEventListener('DOMContentLoaded', function () {
		  // 요소를 선택합니다.
		  const toggleSwitch = document.querySelectorAll('.toggle-button');
		  const myCheck2Elements = document.querySelectorAll('.my-check-2');
		  const myCheck3Elements = document.querySelectorAll('.day-of-the-week');
		  const toggleSwitch2 = document.getElementById("pushAlamSetting");
		  const toggleSwitch3 = document.getElementById("doNotDisturbSetting");

		  toggleSwitch.forEach(($toggle) => {
			    $toggle.onclick = () => {
			      $toggle.classList.toggle('active');
			      
			      if ($toggle === toggleSwitch2) {
			        myCheck2Elements.forEach(($myCheck2) => {
			          if (!toggleSwitch2.classList.contains('active')) {
			            $myCheck2.classList.remove('active');
			          } 
			        });
			      }
			      if ($toggle === toggleSwitch3) {
			        myCheck3Elements.forEach(($myCheck3) => {
			          if (!toggleSwitch3.classList.contains('active')) {
			            $myCheck3.classList.remove('active');
			          } 
			        });
			      }
			    }
			  });
		  
		  
		  myCheck2Elements.forEach(($myCheck2) => {
		    $myCheck2.onclick = () => {
		      if (toggleSwitch2.classList.contains('active')) {
		        $myCheck2.classList.toggle('active');
		      }
		    };
		  });
		  
		  myCheck3Elements.forEach(($myCheck3) => {
		    $myCheck3.onclick = () => {
		      if (toggleSwitch3.classList.contains('active')) {
		        $myCheck3.classList.toggle('active');
		      }
		    };
		  });
		  
		});
	 
	 document.addEventListener('DOMContentLoaded', function () {
         const darkThemeSetting = document.getElementById("darkThemeSetting");
         const lightThemeSetting = document.getElementById("lightThemeSetting");

         darkThemeSetting.onclick = () => {
             document.getElementById('leftArea').style.background = '#2c2a34';
             document.querySelector('.header').style.background = '#2c2a34';
             darkThemeSetting.classList.add('active');
             lightThemeSetting.classList.remove('active');
         };

         lightThemeSetting.onclick = () => {
             document.getElementById('leftArea').style.background = '#00b01c';
             document.querySelector('.header').style.background = '#00b01c';
             darkThemeSetting.classList.remove('active');
             lightThemeSetting.classList.add('active');
         };
     });
	 

	 document.addEventListener('DOMContentLoaded', function () {
	 const randomColorSetting = document.getElementById("randomColorSetting");
     const whiteColorSetting = document.getElementById("whiteColorSetting");
     
     randomColorSetting.onclick = () => {
    	 randomColorSetting.classList.add('active');
    	 whiteColorSetting.classList.remove('active');
     };

     whiteColorSetting.onclick = () => {
    	 randomColorSetting.classList.remove('active');
    	 whiteColorSetting.classList.add('active');
     };
	 });
	 
	 document.addEventListener('DOMContentLoaded', function () {
	 const useFavoritesSetting = document.getElementById("useFavoritesSetting");
     const notUseFavoritesSetting = document.getElementById("notUseFavoritesSetting");
     
     useFavoritesSetting.onclick = () => {
    	 useFavoritesSetting.classList.add('active');
    	 notUseFavoritesSetting.classList.remove('active');
     };

     notUseFavoritesSetting.onclick = () => {
    	 useFavoritesSetting.classList.remove('active');
    	 notUseFavoritesSetting.classList.add('active');
     };
	 });
	 document.addEventListener('DOMContentLoaded', function () {
	 const popup1 = document.querySelector(".temp-popup1");
     const starResetBtn = document.getElementById("starResetBtn");
     const cancel = document.querySelector(".cancel-event");
     const submit = document.querySelector(".submit-event");
     
     starResetBtn.onclick = () => {
    	 popup1.classList.remove('d-none');
    	 popup1.classList.add('d-block');
     };

     cancel.onclick = () => {
    	 popup1.classList.remove('d-block');
    	 popup1.classList.add('d-none');
     };
     submit.onclick = () => {
    	 popup1.classList.remove('d-block');
    	 popup1.classList.add('d-none');
     };
	 });
	 
	 document.addEventListener('DOMContentLoaded', function () {
	 const temppopup3 = document.querySelector(".temp-popup3");
     const invitebtn = document.querySelector(".invite-btn");
     const close = document.querySelector(".close-invite-layer-btn em");
     
     invitebtn.onclick = () => {
    	 temppopup3.classList.remove('d-none');
    	 temppopup3.classList.add('d-block');
     };

     close.onclick = () => {
    	 temppopup3.classList.remove('d-block');
    	 temppopup3.classList.add('d-none');
     };
	 });
	 
	 document.addEventListener('DOMContentLoaded', function () {
	 const popup2 = document.querySelector(".temp-popup2");
     const labeladdbutton = document.querySelector(".label-add-button");
     const cancel1 = document.querySelector(".cancel-event1");
     const submit1 = document.querySelector(".submit-event1");
     
     labeladdbutton.onclick = () => {
    	 popup2.classList.remove('d-none');
    	 popup2.classList.add('d-block');
     };

     cancel1.onclick = () => {
    	 popup2.classList.remove('d-block');
    	 popup2.classList.add('d-none');
     };
     document.querySelector('.submit-event1').addEventListener('click', function() {
    	    var folderName = document.querySelector('.popup-input').value;

    	        var ulElement = document.getElementById('allLabelUl');
    	        var liElement = document.createElement('li');
    	        liElement.setAttribute('class', 'label-item');
    	        
    	        var iElement = document.createElement('i');
    	        iElement.setAttribute('class', 'fa-solid fa-tags');
    	        iElement.setAttribute('style', 'color: #999; margin-right:10px;');
    	        
    	        var spanElement = document.createElement('span');
    	        spanElement.setAttribute('class', 'js-label-name js-mouseover ellipsis');
    	        spanElement.innerText = folderName;
    	        
    	        var aElement = document.createElement('a');
    	        aElement.setAttribute('href', '#');
    	        aElement.setAttribute('class', 'js-label-setting-button flow-dash-three');
    	        
    	        liElement.appendChild(iElement);
    	        liElement.appendChild(spanElement);
    	        liElement.appendChild(aElement);
    	        ulElement.appendChild(liElement);
    	        
    	        // 폴더 생성 후, 팝업 닫기
    	        document.querySelector('.cancel-event1').click();
    	});
	 });
	 
	 $(function(){
		    $(".left-menu-item").click(function() {
		        if (!$(this).hasClass("js-project-more-button")) {
		            $(".left-menu-item").removeClass('with-active');
		            $(this).addClass('with-active');
		        }
		    });
		    $("#item1, #item2, #item3, #item4").click(function() {
		        var itemId = $(this).attr("id").replace("item", "");
		        $("#menu" + itemId).addClass('with-active');
		    });
		});
	    
	 $(function () {
		  $(".bookmark-button").click(function () {
		    $(this).toggleClass('unstar');
		  });
		});
	 $(function () {
	      
	      // detailSettingLayer를 토글하는 함수
	      $("#detailSettingTopButton").click(function () {
	        $("#detailSettingLayer").toggle();
	      });

	      // detailSettingLayer의 범위를 벗어나는 곳을 클릭하면 detailSettingLayer의 display를 none으로 설정
	      $(document).click(function (event) {
	        if (!$(event.target).closest('#detailSettingLayer').length && !$(event.target).closest('#detailSettingTopButton').length) {
	          $('#detailSettingLayer').css('display', 'none');
	        }
	      });
	      
	    });
	 
	 $(function () {
	      $("#detailSettingColorBtn").click(function () {
	    	  $('.color-popup').removeClass('d-none');
	    	  $('.color-popup').addClass('d-block');
	    	  $('#detailSettingLayer').css('display', 'none');
	      });
	    });
	 $(function () {	      
	      $("#detailSettingLabelBtn").click(function () {
	    	  $('.label-popup').removeClass('d-none');
	    	  $('.label-popup').addClass('d-block');
	    	  $('#detailSettingLayer').css('display', 'none');
	      });
	    });

	 $(function() {
		    $(".color-item").click(function() {
		        $(".color-item").removeClass("project-color-check-active-1");
		        $(this).addClass("project-color-check-active-1");
		    });
		    $(".flow-pop-sub-button-2").click(function() {
		        const selectedColorCode = $(".project-color-check-active-1")
		            .attr("class")
		            .replace("color-item", "")
		            .replace("project-color-check-active-1", "")
		            .trim();

		        // HTMLElement를 가져와 classList를 사용한 클래스 조작
		        const projectColorElement = document.getElementById("projectColor");
		        projectColorElement.classList.remove(...projectColorElement.classList);
		        projectColorElement.classList.add("project-color", selectedColorCode);

		        $(".flow-all-background-1").removeClass("d-block").addClass("d-none");
		    });
		    $(".flow-pop-sub-button-1").click(function() {
		        $(".flow-all-background-1").removeClass("d-block").addClass("d-none");
		    });
		});
	 $(document).ready(function() {
		    // 기존 클릭 이벤트
		    $(".flow-close-type-1").click(closeFlow);

		    // ESC 키를 눌렀을 때 이벤트를 추가합니다.
		    $(document).keydown(function(event) {
		        if (event.which === 27) {
		            closeFlow();
		        }
		    });

		    // 기존 클릭 이벤트와 동일한 기능을 수행하는 closeFlow 함수를 정의합니다.
		    function closeFlow() {
		        $(".flow-all-background-1").removeClass("d-block");
		        $(".flow-all-background-1").addClass("d-none");
		    }
		});
	$(function() {
		$('#projectDetailSearchTopButton').click(function(){
			$('#projectDetailSearchLayer').toggle();
		});
	});

</script>
</head>
<body>
<div id="allMainContent" class="dark main-wrap">
<div class= "main-top">
	<header class="header">
		<div id="business" class="business-version-free">
			<div>
				<span class="d-day">D-5</span>
				<div class="business-free-text">
					<span id="versionLabel" onmouseover="showTooltip()" onmouseout="hideTooltip()">비즈니스 프로 버전 무료 체험 중</span>
					<p id="tooltipArea" class="tooltip-square" style="display: none;">
						<span id="versionMessage">비즈니스 프로버전 무료체험 중 입니다.(D5)</span><br>
						<strong>무료기간 종료시, 사용이 중지됩니다.</strong><br> 
					</p>
				</div>
				<button class="pay-button" style="display: inline-block;">
					결제하기</button>
			</div>
		</div>
		<div class="main-search-area cursor-pointer">
            <form id="searchPopupTopButton" class="main-search clearfix">
                <div class="main-search-box">
                    <input type="text" class="cursor-pointer js-main-search-box-placeholder" placeholder="검색"  >
                    <!-- input value 값 존재 시 search-delete-button active  -->
                </div>
                <button type="button" class="js-detail-search detail-search-button">옵션</button>
            </form>
					<div id="searchPopupLayer" class="name-type-seach-popup"
						data-search-area-code="IN_TONG"
						style="top: 5px; right: 30%; display: none;">
						<div class="search-popup-header">
							<div class="search-popup-input">
								<i class="js-search-icon icon-search"></i>
								<div class="js-add-section project-blue-button" data-code="none"></div>
								<div id="searchPopupInputWrapper" style="display: flex;">
									<input id="searchPopupInput" type="text"
										class="name-type-shift-txt" maxlength="20" autocomplete="off"
										placeholder="검색어를 입력해주세요">
								</div>
								<button class="js-search-del btn-search-delete">
									<i></i>
								</button>
							</div>
						</div>
						<div class="js-search-section-div">
							<p>
								카테고리 <i class="fa-solid fa-circle-info" id="icon"></i>
							</p>
							<ul class="section-name-list">
								<li data-code="project"
									class="js-search-section section-name-type-1"><a href="#">
										<div class="section-name-icon-1"></div> <span
										class="js-section-name">프로젝트</span>
								</a></li>
								<li data-code="post"
									class="js-search-section section-name-type-2"><a href="#">
										<div class="section-name-icon-2"></div> <span
										class="js-section-name">글 · 댓글</span>
								</a></li>

							</ul>
						</div>
						<div id="detailSearchArea" style="display: none;">
							<p>검색 옵션</p>
							<div class="detail-search-conditions">
								<ul class="conditions-group">
									<li class="js-project-name-search-filter" style="display: none">
										<div class="condition-cell title">프로젝트</div>
										<div class="condition-cell">
											<input type="text" style="width: 100%;"
												placeholder="프로젝트명을 입력하세요">
										</div>
									</li>
									<li class="js-register-name-search-filter"
										style="display: none">
										<div class="condition-cell title">작성자</div>
										<div class="condition-cell">
											<input type="text" style="width: 100%;"
												placeholder="작성자명 입력 (여려명 입력시, 콤마로 구분)">
										</div>
									</li>
									<li class="js-participant-name-search-filter"
										style="display: none">
										<div class="condition-cell title">참여자</div>
										<div class="condition-cell">
											<input type="text" style="width: 100%;"
												placeholder="참여자명 입력 (여려명 입력시, 콤마로 구분)">
										</div>
									</li>
									<li class="js-period-type-search-filter" data-code="unlimit"
										style="display: block;">
										<div class="condition-cell title">기간 설정</div>
										<div class="condition-cell" style="width: auto;">
											<ul class="target-select-group">
												<li><input id="전체" type="radio" name="period-type"
													class="radio-input " data-code="unlimit" data=""> <label
													for="전체" class="js-period-type radio-label-checkbox"
													data-code="unlimit">전체</label></li>

												<li><input id="오늘" type="radio" name="period-type"
													class="radio-input " data-code="today" data=""> <label
													for="오늘" class="js-period-type radio-label-checkbox"
													data-code="today">오늘</label></li>

												<li><input id="7일" type="radio" name="period-type"
													class="radio-input " data-code="week" data=""> <label
													for="7일" class="js-period-type radio-label-checkbox"
													data-code="week">7일</label></li>

												<li><input id="1개월" type="radio" name="period-type"
													class="radio-input " data-code="month" data=""> <label
													for="1개월" class="js-period-type radio-label-checkbox"
													data-code="month">1개월</label></li>

												<li><input id="3개월" type="radio" name="period-type"
													class="radio-input " data-code="thirdMonth" data="">
													<label for="3개월"
													class="js-period-type radio-label-checkbox"
													data-code="thirdMonth">3개월</label></li>

												<li><input id="6개월" type="radio" name="period-type"
													class="radio-input " data-code="sixthMonth" checked="">
													<label for="6개월"
													class="js-period-type radio-label-checkbox"
													data-code="sixthMonth">6개월</label></li>

												<li><input id="1년" type="radio" name="period-type"
													class="radio-input " data-code="year" data=""> <label
													for="1년" class="js-period-type radio-label-checkbox"
													data-code="year">1년</label></li>

												<li><input id="기간선택" type="radio" name="period-type"
													class="radio-input js-date-select-input" data-code="select"
													data=""> <label for="기간선택"
													class="js-period-type radio-label-checkbox"
													data-code="select">기간선택</label>
													<div class="search-period-wr">
														<div class="js-search-pickr-layer" id="calender"
															style="display: none;">
															<p>
																<input type="text" id="datepicker1"
																	style="border: 1px solid black; width: 80px; float: left; border-radius: 5px;">&nbsp;
																~ &nbsp; <input type="text" id="datepicker2"
																	style="border: 1px solid black; width: 80px; float: right; border-radius: 5px;">
															</p>
														</div>
													</div></li>
											</ul>
										</div>
									</li>
									<li class="js-tmpl-type-search-filter" style="display: block;">
										<div class="condition-cell title">대상</div>
										<div class="condition-cell">
											<ul class="target-select-group">
												<li><input id="전체" type="radio" name="tmpl-type"
													class="radio-input" data-code="0" checked=""> <label
													for="전체" class="js-tmpl-type radio-label-checkbox"
													data-code="0">전체</label></li>

												<li><input id="글" type="radio" name="tmpl-type"
													class="radio-input" data-code="1" data=""> <label
													for="글" class="js-tmpl-type radio-label-checkbox"
													data-code="1">글</label></li>

												<li><input id="업무" type="radio" name="tmpl-type"
													class="radio-input" data-code="4" data=""> <label
													for="업무" class="js-tmpl-type radio-label-checkbox"
													data-code="4">업무</label></li>

												<li><input id="일정" type="radio" name="tmpl-type"
													class="radio-input" data-code="3" data=""> <label
													for="일정" class="js-tmpl-type radio-label-checkbox"
													data-code="3">일정</label></li>

												<li><input id="할 일" type="radio" name="tmpl-type"
													class="radio-input" data-code="2" data=""> <label
													for="할 일" class="js-tmpl-type radio-label-checkbox"
													data-code="2">할 일</label></li>

												<li><input id="투표" type="radio" name="tmpl-type"
													class="radio-input" data-code="5" data=""> <label
													for="투표" class="js-tmpl-type radio-label-checkbox"
													data-code="5">투표</label></li>

												<li><input id="댓글" type="radio" name="tmpl-type"
													class="radio-input" data-code="-1" data=""> <label
													for="댓글" class="js-tmpl-type radio-label-checkbox"
													data-code="-1">댓글</label></li>
											</ul>
										</div>
									</li>
									<li class="js-file-type-search-filter" style="display: none">
										<div class="condition-cell title">파일유형</div>
										<div class="condition-cell">
											<ul class="target-select-group"></ul>
										</div>
									</li>
								</ul>
								<div class="condition-button-area">
									<div class="condition-left"
										style="float: left; margin-left: 20px;">
										<button type="button" class="js-filter-reset condition-reset">
											초기화</button>
									</div>
									<div class="condition-right"
										style="margin-right: 20px; float: right;">
										<button class="js-filter-cancel condition-button cancel"
											onclick="closePopup1()">취소</button>
										<button class="js-filter-search condition-button search">검색</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="rightTopMenu" class="top-btns">
					&lt;
					<button type="button" id="organizationTopButton"
						class="btn-organization js-mouseover js-button-tooltip"
						style="display: inline-block;" onclick="openPopup()">
						<i class="fa-solid fa-sitemap"
							style="color: #ffffff; font-size: 25px;"></i>
					</button>
					<button type="button" id="chattingTopButton"
						class="btn-chatting js-mouseover js-button-tooltip"
						style="margin: 0 10px;" onclick="openPopup1()">
						<i class="fa-regular fa-comment"
							style="color: #ffffff; font-size: 25px;"><span></span></i> <i
							id="chatTopCount" class="label-chat" style="display: none">0</i>
					</button>
					<button type="button" id="alarmTopButton"
						class="btn-alarm js-mouseover
            js-button-tooltip"
						onclick="openPopup9()">
						<i class="fa-regular fa-bell"
							style="color: #ffffff; font-size: 25px;"></i> <i
							id="alarmTopCount" class="label-alarm" style="display: none;">10</i>
					</button>

					<button type="button" id="accountTopButton" class="btn-profile"
						style="margin-left: 15px;" onclick="openPopup11()">
						<span id="ProfileImg" class="profile-area"
							style="background-image: url('https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&height=400')"></span>
					</button>
				</div>

				<ul id="accountLayer" class="modal-account d-none"
					style="display: none;">
					<li class="user-area">
						<p class="js-profile user-img"
							style="background-image: url('https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400&');"></p>
						<div class="user-info">
							<strong class="js-user-name js-mouseover">박형근</strong> <span
								class="js-version">비즈니스 프로 버전</span>
						</div>
					</li>
					<li id="topProfile" class="user-profile" onclick='openPopup12()'>
						<i class="fa-regular fa-user" style="color: #000000;"></i> 내 프로필
					</li>
					<li id="mySettingOpenBtn" onclick='openPopup13()'><i
						class="fa-solid fa-gear" style="color: #000000;"></i> 환경설정</li>
					<li id="desktopDownloadBtn" class="download-desktop"
						href="https://flow.team/main.act"><i
						class="fa-solid fa-download" style="color: #000000;"></i> Desktop
						앱 다운로드</li>
					<li id="logoutBtn"><i
						class="fa-solid fa-arrow-right-from-bracket"
						style="color: #000000;"></i> 로그아웃</li>
				</ul>
			</header>
		</div>
		<article id="organizationLayer" class="side-wr d-none"
			style="display: none;">
			<section id="orgChartGuide" class="guest-upgrade-organization"
				style="display: flex;">
				<button id="OrganCloseBtn" class="btn-close" onclick="openPopup()">
					<i class="fa-solid fa-x"></i>
				</button>
				<div>
					<strong>조직도</strong>
					<p>
						조직도를 만들고<br>직원들을 관리해 보세요!
					</p>

					<a href="https://support.flow.team/hc/ko/articles/4727122046489"
						target="_blank">자세히 알아보기</a>
					<form
						action="https://flow.team/flow_admin.act?MENU=flow-org-management">
						<button id="makeOrgChart">조직도 생성</button>
					</form>
				</div>
			</section>
		</article>
		<article id="chattingLayer" class="side-wr d-none"
			style="display: none;">
			<div class="menu-top">
				<strong class="js-menu-txt">채팅</strong>
				<button type="button"
					class="js-allChat-alarm alarm on js-mouseover js-button-tooltip">
					<i class="icon-alarm"></i>
				</button>
				<button id="chatCloseBtn" class="btn-close" onclick="openPopup1()">
					<i class="fa-solid fa-x"></i>
				</button>
			</div>
			<div class="side-contents">
				<ul id="chatTabMenu" class="tab-menu"
					style="display: flex; padding-left: 17px;">
					<li id="chatBtn"><span class="popup-tab chat on" tabindex="0">채팅</span></li>
					<li id="contactBtn"><span class="popup-tab chat" tabindex="0">연락처</span>
					</li>
				</ul>
				<div class="popup-right">
					<button type="button" class="js-new-chat popup-button chat">
						<i class="icon-chat"></i> 새 채팅
					</button>
				</div>

				<div class="all-setup-type-2">
					<i class="fa-solid fa-magnifying-glass" style="color: #050505;"></i>
					<input id="chattingSearchInput" type="text"
						class="all-setup-input-type-1" placeholder="이름, 채팅방명 검색"
						autocomplete="off">
					<button class="js-input-del btn-search-delete absolute-r r-28"
						style="display: block;">
						<i></i>
					</button>
				</div>
			</div>
		</article>
		<article id="alarmLayer" class="side-wr d-none" style="display: none;">
			<div class="menu-top">
				<strong style="color: black;">알림</strong>
				<button class="js-close-event btn-close" onclick="openPopup9()">
					<i class="fa-solid fa-x"></i>
				</button>
			</div>
			<div class="side-contents">
				<ul id="notReadFilter" class="tab-menu" style="border-bottom: none;">
					<li class="js-alarm js-unread on" style="margin-left: 17px;">미확인</li>
					<li class="js-alarm js-read ">전체</li>
					<li id="readAllAlarm">모두읽음</li>
				</ul>
				<!-- 알림 리스트 -->
				<div class="all-setup-type-2">
					<i class="fa-solid fa-magnifying-glass" id="glass2"
						style="color: #050505;"></i> <input id="alarmSearchInput"
						type="text" class="all-setup-input-type-1" placeholder="검색"
						autocomplete="off">

					<div class="x-option-wrap">
						<button class="js-input-del btn-search-delete"
							style="display: none;">
							<i></i>
						</button>
						<a href="#" id="alarmSearchFilterTopButton"
							class="all-setup-detail-text-1" onclick="openPopup10()">옵션</a>
					</div>
					<div id="alarmSearchFilterLayer" class="popup-filter-type-1 d-none"
						style="display: none;">
						<div class="js-project-title js-filter-item setup-detail-type-1"
							data-num="0">
							<a href="#"> <em onclick="changeClass()"></em> <span
								style="color: #6449fc;">프로젝트명</span>
							</a>
						</div>
						<div class="js-contents js-filter-item setup-detail-type-1"
							data-num="1">
							<a href="#"> <em onclick="changeClass1()"></em> <span
								style="color: #6449fc;">내용</span>
							</a>
						</div>
						<div class="js-register-id js-filter-item setup-detail-type-1"
							data-num="2">
							<a href="#"> <em onclick="changeClass2()"></em> <span
								style="color: #6449fc;">작성자</span>
							</a>
						</div>
					</div>
				</div>
				<div class="name-setup-type-2 scroll-mask">
		            <ul id="alarmUl" scroll-direction="0">
			            <div class="js-project-null project-null-t-1 undefined">   
				            <div class="project-null-t-2 ">       
				            	<div class=" project-null-t-3 search-null"></div>       
				            	<span>검색 결과가 없습니다.</span>   
				            </div>
		            	</div>
            		</ul>
       			 </div>
			</div>
		</article>

		<div id="mainBodyWrap" class="main-body-wrap">
			<!-- 왼쪽 -->
			<div id="leftArea" class="main-header-1" style="float: left;">
				<div id="leftTask" class="left-task active"
					style="padding-bottom: 32px;">
					<div class="logo-area logo-display-wrap" style="display: block">
						<a class="js-logo logo-box">
							<h1 class="logo-1">
								<img src="Images/with_logo.png" class="logo-flow" alt="Flow">
							</h1>
						</a>
					</div>
					<a href="#" class="js-left-menu">
						<div id="projectMakeButton" class="new-project-1">
							<div class="button-suport-1"></div>
							새 프로젝트
						</div>
					</a>
					<ul id="leftMenuUl" class="menu-group js-left-menu mgt-20">
						<li data-code="main" class="my-project left-menu-item"><a
							href="#"> <i class="fa-solid fa-house"
								style="color: #ffffff; margin-right: 10px;"></i>내 프로젝트
						</a></li>
						<li data-code="open" id="glass" class="left-menu-item"><a
							href="#" style="margin-left: 23px;"> 회사 공개 프로젝트</a></li>
						<li data-code="nokeep" id="menu1" class="left-menu-item d-none"
							style="display: none;"><a href="#"><i
								class="fa-regular fa-envelope-open"
								style="color: #ffffff; margin-right: 10px;"></i>미분류</a></li>
						<li data-code="unread" id="menu2" class="left-menu-item d-none"
							style="display: none;"><a href="#"><i
								class="fa-regular fa-envelope"
								style="color: #ffffff; margin-right: 10px;"></i>미확인 </a></li>
						<li data-code="star" id="menu3" class="left-menu-item d-none"
							style="display: none;"><a href="#"><i
								class="fa-regular fa-star"
								style="color: #ffffff; margin-right: 10px;"></i>즐겨찾기</a></li>
						<li data-code="hidden" id="menu4" class="left-menu-item d-none"
							style="display: none;"><a href="#"><i
								class="fa-regular fa-eye-slash"
								style="color: #ffffff; margin-right: 8px;"></i>숨김</a></li>
						<li class="js-project-more-button left-menu-item"
							data-code="project-more" onclick="openPopup2()"><a href="#">
								<span style="font-size: 15px;">&#x22EE</span>&nbsp;&nbsp;&nbsp;&nbsp;더보기
						</a>

							<ul
								class="js-project-more-layer check-menu-popup left-more-menu d-none"
								id="plus" style="display: none;">
								<li>
									<button data-code="nokeep" id="item1" type="button"
										class="left-menu-item" style="display: block;"
										onclick="openPopup3()">
										<i class="fa-regular fa-envelope-open"
											style="color: #999; margin-right: 5px;"></i>미분류
									</button>
								</li>
								<li>
									<button data-code="unread" id="item2" type="button"
										class="left-menu-item" style="display: block;"
										onclick="openPopup4()">
										<i class="fa-regular fa-envelope"
											style="color: #999; margin-right: 5px;"></i>미확인
									</button>
								</li>
								<li>
									<button data-code="star" id="item3" type="button"
										class="left-menu-item" style="display: block;"
										onclick="openPopup5()">
										<i class="fa-regular fa-star"
											style="color: #999; margin-right: 5px;"></i>즐겨찾기
									</button>
								</li>
								<li>
									<button data-code="hidden" id="item4" class="left-menu-item"
										style="display: block;" onclick="openPopup6()">
										<i class="fa-regular fa-eye-slash"
											style="color: #ccc; margin-right: 4px;"></i>숨김
									</button>
								</li>
							</ul></li>
					</ul>
					<div style="overflow: scroll;">
						<ul id="leftScroll" class="menu-accordion-group scroll-mask thin">
							<li>
								<div class="menu-accordion-button active left-menu-item"
									data-code="collect-more">
									모아보기<i class="fa-solid fa-angle-up"
										style="color: #ccc; margin-left: 100px;"
										onclick="openPopup7()"></i>
								</div>
								<div class="menu-accordion"
									style="display: block; margin-left: 30px;">
									<ul class="menu-accordion-list" id="menu11">
										<li data-code="task" class="left-menu-item"><a href="#"><i
												class="fa-solid fa-list-ul"
												style="font-size: 18px; color: #999; margin-right: 10px;"></i>전체
												업무</a></li>
										<li data-code="gantt" class="left-menu-item"><a href="#"><i
												class="fa-solid fa-bars-staggered"
												style="font-size: 18px; color: #999; margin-right: 10px;"></i>간트차트</a>
										</li>
										<li data-code="schd" class="left-menu-item"><a href="#">
												<i class="fa-regular fa-calendar"
												style="font-size: 18px; color: #999; margin-right: 12px;"></i>캘린더
										</a></li>
										<li data-code="file" class="left-menu-item"><a href="#"><i
												class="fa-solid fa-box-archive"
												style="font-size: 18px; color: #999; margin-right: 10px;"></i>파일함</a>
										</li>
										<li data-code="bookmark" class="left-menu-item"><a
											href="#"><i class="fa-regular fa-bookmark"
												style="font-size: 18px; color: #999; margin-right: 13px;"></i>북마크</a>
										</li>
										<li data-code="mention" class="left-menu-item"><a
											href="#"><span style="font-size: 15px;">@</span>&nbsp;&nbsp;&nbsp;나를
												언급</a></li>
										<li data-code="mypost" class="left-menu-item"><a href="#"><i
												class="fa-solid fa-chalkboard-user"
												style="font-size: 18px; color: #999; margin-right: 9px;"></i>내
												게시물</a></li>
										<li data-code="tmpPost" class="left-menu-item"><a
											href="#"><i class="fa-solid fa-file-circle-exclamation"
												style="font-size: 18px; color: #999; margin-right: 9px;"></i>임시저장</a>
										</li>
									</ul>
								</div>
							</li>
							<li style="display: block;">
								<div id="RecentProjectButton"
									class="menu-accordion-button left-menu-item active"
									data-code="recent-project-more">
									최근 업데이트<i class="fa-solid fa-angle-up"
										style="color: #ccc; margin-left: 73px;" onclick="openPopup8()"></i>
								</div>
								<div class="menu-accordion">
									<div class="bg-type lnb">
										<ul id="RecentProjectUl" class="menu-accordion-list">
<!-- 											<li class="recent-project-item" data-project-srno="16" -->
<!-- 												data-color-code="4" home-tab="FEED"> -->
<!-- 												<div class="squre-type color-code-4 new"> -->
<!-- 													<div class=""></div> -->
<!-- 												</div> <span class="js-mouseover ellipsis">프로젝트1</span> -->
<!-- 											</li> -->

<!-- 											<li class="recent-project-item" data-project-srno="1853401" -->
<!-- 												data-color-code="3" home-tab="FEED"> -->
<!-- 												<div class="squre-type color-code-3 "> -->
<!-- 													<div class=""></div> -->
<!-- 												</div> <span class="js-mouseover ellipsis">프로젝트2</span> -->
<!-- 											</li> -->

<!-- 											<li class="recent-project-item" data-project-srno="1853402" -->
<!-- 												data-color-code="2" home-tab="FEED"> -->
<!-- 												<div class="squre-type color-code-2 "> -->
<!-- 													<div class=""></div> -->
<!-- 												</div> <span class="js-mouseover ellipsis">프로젝트3</span> -->
<!-- 											</li> -->

<!-- 											<li class="recent-project-item" data-project-srno="1853400" -->
<!-- 												data-color-code="2" home-tab="FEED"> -->
<!-- 												<div class="squre-type color-code-2 "> -->
<!-- 													<div class=""></div> -->
<!-- 												</div> <span class="js-mouseover ellipsis">프로젝트4</span> -->
<!-- 											</li> -->

<!-- 											<li class="recent-project-item" data-project-srno="1848469" -->
<!-- 												data-color-code="6" home-tab="FEED"> -->
<!-- 												<div class="squre-type color-code-6 "> -->
<!-- 													<div class=""></div> -->
<!-- 												</div> <span class="js-mouseover ellipsis">프로젝트5</span> -->
<!-- 											</li> -->
										</ul>
									</div>
								</div>
							</li>
							<li>
								<div id="allLabelLeftButton" data-code="label-more"
									class="menu-accordion-button left-menu-item active">
									프로젝트 폴더
									<button class="js-label-add label-add-button">
										<i class="fa-solid fa-plus" style="color: red;"></i>
									</button>
									<i class="fa-solid fa-angle-up"
										style="color: #ccc; margin-left: 40px;"
										onclick="openPopup14()"></i>
								</div>
								<div class="menu-accordion">
									<div class="bg-type lnb"
										style="border-bottom: 1px solid #434149;">
										<ul id="allLabelUl" class="menu-accordion-list ui-sortable">
											<li id="label-1" class="label-item"><i
												class="fa-solid fa-tags"
												style="color: #999; margin-right: 10px;"></i> <span
												class="js-label-name js-mouseover ellipsis">마케팅</span> <a
												href="#" class="js-label-setting-button flow-dash-three">
											</a></li>

											<li id="label-2" class="label-item"><i
												class="fa-solid fa-tags"
												style="color: #999; margin-right: 10px;"></i> <span
												class="js-label-name js-mouseover ellipsis">디자인</span> <a
												href="#" class="js-label-setting-button flow-dash-three">
											</a></li>

											<li id="label-3" class="label-item"><i
												class="fa-solid fa-tags"
												style="color: #999; margin-right: 10px;"></i> <span
												class="js-label-name js-mouseover ellipsis">엔지니어링</span> <a
												href="#" class="js-label-setting-button flow-dash-three">
											</a></li>
										</ul>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div
						class="js-label-setting-layer setting-popup flow-small-layer-1 cursor-pointer"
						style="display: none">
						<div class="label-edit flow-name-size">
							<i></i><a href="#"><span>수정</span></a>
						</div>
						<div class="label-delete flow-dash-icon">
							<i></i><a href="#"><span>삭제</span></a>
						</div>
					</div>
					<ul id="leftBottomUl" class="menu-group admin">
						<li data-code="invite-member"
							class="js-invite-employee-button left-menu-item invite-btn">
							<a href="#"><i class="fa-solid fa-people-group"
								style="color: #999; margin-right: 10px;"></i>직원 초대</a>
						</li>
						<li data-code="manager-admin" class="left-menu-item admin-btn">
							<a href="#"><i class="fa-solid fa-user-gear"
								style="color: #999; margin-right: 10px;"></i>어드민</a>
						</li>
					</ul>
				</div>
			</div>


			<!-- 오른쪽 상단 -->
			<div class="main-container" style="overflow: hidden;">
				<div id="topSettingBar" class="main-header" style="display: block">
					<div id="detailTop" class="project-detail title-1"
						style="display: block;">
						<div class="project-detail-header">
							<div id="ProjectTopArea" style="display: block;">
								<div class="project-color-area">
									<i id="projectColor" class="project-color"></i>
								</div>
								<div class="project-header-group">
									<div class="project-title-area">
										<div class="project-option-area">
											<button id="projectStar" class="bookmark-button">
												<span class="blind">즐겨찾기</span>
											</button>
											<button id="detailSettingTopButton" class="set-btn">
												<span></span> <span></span> <span></span>
											</button>
											<div id="detailSettingLayer" class="project-setup-wrap"
												style="display: none">
												<div class="project-setup-header">
													<span>프로젝트 번호</span> <em id="detailSettingProjectSrno">1852542</em>
												</div>
												<ul id="detailSettingGroup" class="setup-group">
													<li id="detailSettingColorBtn"><a href="#"> <i
															class="icon-set-color"></i>색상 설정
													</a></li>
													<li id="detailSettingLabelBtn"><a href="#"> <i
															class="icon-set-label"></i> 프로젝트 폴더 설정
													</a></li>
													<li id="detailSettingPushAlarmBtn"><a href="#"> <i
															class="icon-set-alarm"></i>알림 설정
													</a></li>
													<li id="detailSettingHideBtn"><a id="hideText"
														href="#"> <i class="icon-set-hide"></i> 숨김
													</a></li>
													<li id="detailSettingProjectExitBtn"><a href="#">
															<i class="icon-set-out"></i>프로젝트 나가기
													</a></li>
													<li id="detailSettingProjectUpdateBtn"><a href="#">
															<i class="icon-set-modify"></i>프로젝트 수정
													</a></li>

													<li id="detailSettingProjectDeleteBtn"><a href="#">
															<i class="icon-set-delete"></i>프로젝트 삭제
													</a></li>
												</ul>
											</div>
										</div>
										<span class="terminate-project-badge">종료</span>
										<h3 id="projectTitle"
											class="project-title ellipsis1 js-mouseover"
											mouseover-text="Yo!">Yo!</h3>
										<ul class="project-status-group">
											<li id="lockIcon" style="display: none"><i
												class="sprite-detail icon-locked js-icon-locked"><span
													class="blind">관리자 승인 필요</span></i>
												<div class="tooltip-square">
													<em class="tooltip-title">관리자 승인 필요</em>
													<p class="tooltip-text">프로젝트 관리자의 승인 후 참여가 가능한 프로젝트입니다.</p>
												</div></li>
											<li id="unalarmIcon" style="display: none"><i
												class="sprite-detail icon-unalarm js-icon-un-alarm"> <span
													class="blind">푸시 알림 OFF</span>
											</i>
												<div class="tooltip-square">
													<em class="tooltip-title">푸시 알림 OFF</em>
													<p class="tooltip-text">휴대폰 푸시 또는 브라우저에 알림이 가지 않습니다.
														프로젝트 [알림 설정]메뉴에서 변경할 수 있습니다.</p>
												</div></li>
											<li id="companyIcon" style="display: none;"><i
												class="sprite-detail icon-company js-icon-company"><span
													class="blind">회사 프로젝트</span></i>
												<div class="tooltip-square">
													<em class="tooltip-title">회사 프로젝트</em>
													<p class="tooltip-text">회사 직원 모두가 자동 참여되는 프로젝트로 임의로
														참여자를 내보내거나 외부 직원을 초대할 수 없습니다.</p>
												</div></li>
											<li id="openProjIcon" style="display: inline-block;"><i
												class="sprite-detail icon-open-project js-icon-open-project"><span
													class="blind">회사 공개 프로젝트</span></i>
												<div class="tooltip-square" style="display: none;">
													<em class="tooltip-title">회사 공개 프로젝트</em>
													<p class="tooltip-text">우리 회사 직원이라면 누구나 직접 참여를 요청할 수
														있습니다.</p>
												</div></li>
											<li id="anoymousProj" style="display: none"><i
												class="sprite-detail icon-unknown"><span class="blind">익명
														프로젝트</span></i>
												<div class="tooltip-square">
													<em class="tooltip-title">익명 프로젝트</em>
													<p class="tooltip-text">모든 글/댓글 작성시 익명으로 처리되는 프로젝트입니다.</p>
												</div></li>
											<li style="display: none"><i class="icons-public"></i></li>
											<li id="externalIcon" style="display: inline-block;"><span
												class="badge-out-display js-mouseover"
												mouseover-text="프로젝트에 외부 사용자가 있습니다">외부</span></li>
											<li id="officialIcon" style="display: none"><span
												class="icon-official">공식</span></li>
											<li id="templateIcon" style="display: none"><span
												class="badge-out-display js-mouseover cyan"
												mouseover-text="템플릿으로 설정된 프로젝트입니다. 본 프로젝트에 등록된 게시물, 파일들이 다른 사람들에게 노출될 수 있기에 사용에 유의 바랍니다.">템플릿</span>
											</li>
											<li id="postModDelAuthIcon" style="display: none">
											<span class="badge-out-display js-mouseover"
												mouseover-text="작성된 글 수정/삭제가 제한되어있는 프로젝트입니다">"
		&gt;글 수정 제한
		</span>
		</li>
		<li id="replyModDelAuthIcon" style="display: none"><span
			class="badge-out-display js-mouseover"
			mouseover-text="작성된 댓글 수정/삭제가 제한되어있는 프로젝트입니다
                            >댓글 수정 제한</span>
                        </li>
                        <li id="
												writeeditauthicon"=
			"" style="display: none"> <span
				class="badge-out-display js-mouseover"
				mouseover-text="프로젝트 참여자 모두 수정이 가능한 프로젝트입니다.">공동 수정</span>
		</span></li>
		</ul>
	</div>
	<div class="project-description" style="display: none;">
		<p id="projectContents" class="description-text js-mouseover"
			mouseover-text=""></p>
	</div>
	</div>
	</div>
	</div>
	<button id="projectEndDate" type="button"
		class="project-terminate-button d-none">
		<i class="icons-calendar"></i><span id="projectDDay">D-0</span>
	</button>
	<button id="openInviteLayerBtn" type="button"
		class="project-invite-button color-code-1" style="display: block;">
		<i class="fa-solid fa-user-plus" style="color: #ffffff;"></i>초대하기
	</button>
	</div>
	</div>
	<div id="mainContent" class="main-content scroll-mask"
		style="display: block;" scroll-direction="0">
		<div id="detailLayer" class="main-sub-header project-detail-wrap"
			style="display: block;">
			<div class="project-detail-top default-tab clearfix">
				<ul id="detailTab" class="project-detail-menu"
					style="display: flex;">
					<li class="js-tab-item default-item  active freezing"
						data-code="feed">
						<div>
							<a><i class="fa-solid fa-house" style="color: #000000;"></i>
								피드</a>
						</div>
					</li>
					<li class="js-tab-item    freezing" data-code="task">
						<div>
							<a><i class="ico-home"></i> 업무</a>
						</div>
					</li>
					<li class="js-tab-item    freezing" data-code="gantt">
						<div>
							<a><i class="ico-home"></i> 간트차트</a>
						</div>
					</li>
					<li class="js-tab-item    freezing" data-code="calendar">
						<div>
							<a><i class="ico-home"></i> 캘린더</a>
						</div>
					</li>
					<li class="js-tab-item    freezing" data-code="file">
						<div>
							<a><i class="ico-home"></i> 파일</a>
						</div>
					</li>
					<li class="js-tab-item    freezing" data-code="history">
						<div>
							<a><i class="ico-home"></i> 알림</a>
						</div>
					</li>
				</ul>

				<div id="detailTopSearch"
					class="project-search-area all-file-header-type-3"
					style="display: block;">
					<div class="project-search">
						<img src="Images/돋보기.png;" class="icons-search"> </span> <input
							id="projectSearchInput" type="text" placeholder="검색어를 입력해주세요"
							class="project-search-input" autocomplete="off" maxlength="50">
						<div class="x-option-wrap" style="margin-right: 10px;">
							<button class="js-input-del btn-search-delete"
								style="display: none;">
								<i></i>
							</button>
							<button id="projectDetailSearchTopButton" type="button"
								class="js-detail-top-search-button search-set-button">
								옵션</button>
						</div>
						<div id="projectDetailSearchLayer"
							class="name-type-seach-popup d-none"
							data-search-area-code="IN_PROJECT" style="top: 38px; right: 0px;">
							<p>옵션</p>
							<div class="detail-search-conditions">
								<ul class="conditions-group">
									<li class="js-project-name-search-filter"
										style="display: none;">
										<div class="condition-cell title">프로젝트</div>
										<div class="condition-cell">
											<input type="text" placeholder="프로젝트명을 입력하세요">
										</div>
									</li>
									<li class="js-register-name-search-filter"
										style="display: block;">
										<div class="condition-cell title">작성자</div>
										<div class="condition-cell">
											<input type="text" placeholder="작성자명 입력 (여러명 입력시, 콤마로 구분)"
												style="width: 100%;">
										</div>
									</li>
									<li class="js-participant-name-search-filter d-none"
										style="display: none;">
										<div class="condition-cell title">담당자</div>
										<div class="condition-cell">
											<input type="text" placeholder="참여자명 입력 (여러명 입력시, 콤마로 구분)">
										</div>
									</li>
									<li class="js-period-type-search-filter" data-code="today"
										style="display: block;">
										<div class="condition-cell title">검색기간</div>
										<div class="condition-cell">
											<ul class="target-select-group">
												<li style="width: 110px;"><input
													id="hkbk00@gmail.com_[object Object]_07074a6c-3a58-44d6-af4c-37df20bdc98a"
													type="radio" name="period-type" class="radio-input "
													data-code="unlimit" data=""> <label
													for="hkbk00@gmail.com_[object Object]_07074a6c-3a58-44d6-af4c-37df20bdc98a"
													class="js-period-type radio-label-checkbox"
													data-code="unlimit">전체</label></li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_dfd7a9b3-910f-4dc9-9abd-d9644159b4a6"
													type="radio" name="period-type" class="radio-input "
													data-code="today" checked=""> <label
													for="hkbk00@gmail.com_[object Object]_dfd7a9b3-910f-4dc9-9abd-d9644159b4a6"
													class="js-period-type radio-label-checkbox"
													data-code="today">오늘</label></li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_f516fbec-209d-4d94-978c-d8db74f8de86"
													type="radio" name="period-type" class="radio-input "
													data-code="week" data=""> <label
													for="hkbk00@gmail.com_[object Object]_f516fbec-209d-4d94-978c-d8db74f8de86"
													class="js-period-type radio-label-checkbox"
													data-code="week">7일</label></li>

												<li style="width: 110px;"><input
													id="hkbk00@gmail.com_[object Object]_77eec629-3bb5-4f27-8eec-675ebb71052d"
													type="radio" name="period-type" class="radio-input "
													data-code="month" data=""> <label
													for="hkbk00@gmail.com_[object Object]_77eec629-3bb5-4f27-8eec-675ebb71052d"
													class="js-period-type radio-label-checkbox"
													data-code="month">1개월</label></li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_2095ea66-9cce-44b0-936a-2a5cbd000562"
													type="radio" name="period-type" class="radio-input "
													data-code="thirdMonth" data=""> <label
													for="hkbk00@gmail.com_[object Object]_2095ea66-9cce-44b0-936a-2a5cbd000562"
													class="js-period-type radio-label-checkbox"
													data-code="thirdMonth">3개월</label></li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_57246da8-28d0-4b8c-b869-298cc21e466d"
													type="radio" name="period-type" class="radio-input "
													data-code="sixthMonth" data=""> <label
													for="hkbk00@gmail.com_[object Object]_57246da8-28d0-4b8c-b869-298cc21e466d"
													class="js-period-type radio-label-checkbox"
													data-code="sixthMonth">6개월</label></li>

												<li style="width: 110px;"><input
													id="hkbk00@gmail.com_[object Object]_0cdbad00-a123-4bc2-b84f-9b08f684b8cb"
													type="radio" name="period-type" class="radio-input "
													data-code="year" data=""> <label
													for="hkbk00@gmail.com_[object Object]_0cdbad00-a123-4bc2-b84f-9b08f684b8cb"
													class="js-period-type radio-label-checkbox"
													data-code="year">1년</label></li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_7e5027fe-cffb-4f0c-ab99-57fb0d90fea9"
													type="radio" name="period-type"
													class="radio-input js-date-select-input" data-code="select"
													data=""> <label
													for="hkbk00@gmail.com_[object Object]_7e5027fe-cffb-4f0c-ab99-57fb0d90fea9"
													class="js-period-type radio-label-checkbox"
													data-code="select">기간선택</label>
													<div class="js-search-pickr-layer" id="calender"
														style="display: none;">
														<p>
															<input type="text" id="datepicker6"
																style="border: 1px solid black; width: 80px; float: left; border-radius: 5px;">&nbsp;
															~ &nbsp; <input type="text" id="datepicker7"
																style="border: 1px solid black; width: 80px; float: right; border-radius: 5px;">
														</p>
													</div></li>
											</ul>
										</div>
									</li>
									<li class="js-tmpl-type-search-filter" style="display: block;">
										<div class="condition-cell title">대상</div>
										<div class="condition-cell">
											<ul class="target-select-group">
												<li><input
													id="hkbk00@gmail.com_[object Object]_75926e06-3019-4af5-9030-5ec591518940"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="0" checked=""> <label
													for="hkbk00@gmail.com_[object Object]_75926e06-3019-4af5-9030-5ec591518940"
													class="js-tmpl-type radio-label-checkbox" data-code="0">전체</label>
												</li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_34d6b837-184e-4645-8a82-b699df18f1f5"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="1" data=""> <label
													for="hkbk00@gmail.com_[object Object]_34d6b837-184e-4645-8a82-b699df18f1f5"
													class="js-tmpl-type radio-label-checkbox" data-code="1">글</label>
												</li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_ef936b3d-5170-44cf-b691-ad8e047e4269"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="4" data=""> <label
													for="hkbk00@gmail.com_[object Object]_ef936b3d-5170-44cf-b691-ad8e047e4269"
													class="js-tmpl-type radio-label-checkbox" data-code="4">업무</label>
												</li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_efa07cf7-e210-4b66-ae68-df126bbe55b3"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="3" data=""> <label
													for="hkbk00@gmail.com_[object Object]_efa07cf7-e210-4b66-ae68-df126bbe55b3"
													class="js-tmpl-type radio-label-checkbox" data-code="3">일정</label>
												</li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_ebec96d8-26c5-43df-adbe-81eaa3dddc70"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="2" data=""> <label
													for="hkbk00@gmail.com_[object Object]_ebec96d8-26c5-43df-adbe-81eaa3dddc70"
													class="js-tmpl-type radio-label-checkbox" data-code="2">할일</label></li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_34010ba0-0c9a-430e-9782-065bf82646a2"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="5" data=""> <label
													for="hkbk00@gmail.com_[object Object]_34010ba0-0c9a-430e-9782-065bf82646a2"
													class="js-tmpl-type radio-label-checkbox" data-code="5">투표</label>
												</li>

												<li><input
													id="hkbk00@gmail.com_[object Object]_f752fb7f-08c5-483c-a2f2-47e2ad1cdcd3"
													type="radio" name="tmpl-type" class="radio-input"
													data-code="-1" data=""> <label
													for="hkbk00@gmail.com_[object Object]_f752fb7f-08c5-483c-a2f2-47e2ad1cdcd3"
													class="js-tmpl-type radio-label-checkbox" data-code="-1">댓글</label>
												</li>
											</ul>
										</div>
									</li>
								</ul>
								<div class="condition-button-area">
									<div class="condition-left">
										<button type="button" class="js-filter-reset condition-reset">초기화</button>
									</div>
									<div class="condition-right">
										<button class="js-filter-cancel condition-button cancel">취소</button>
										<button class="js-filter-search condition-button search">검색</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="detailTimeline"
				class="project-detail-inner layer-scroll type2" scroll-direction="0"
				style="display: block;">
				<div class="js-detail-wrap-area small-style-wrap">
					<section id="postTimeline" class="project-detail-container">
						<div class="project-detail-content">
							<div id="taskReportArea">
								<div class="detail-section reports-section"
									style="background: #fff;">
									<div class="section-title-area">
										<h4 class="section-title">
											<span>업무리포트</span>
										</h4>
										<button id="taskReportToggleButton" type="button"
											class="js-report-btn reports-button"
											style="float: right; margin-top: 15px;">
											<i class="fa-solid fa-angle-up" style="color: #ccc;"></i>
										</button>
									</div>
									<!-- 원형차트 -->
									<script>
								document.addEventListener('DOMContentLoaded', () => {
								    const ctx = document.getElementById('myChart');
								    const totalValue = document.getElementById('chart-total');
								
								    const dataValues = [<%=a%>, <%=b%>, <%=c%>, <%=d%>, <%=e%>];
								    const totalSum = dataValues.reduce((a, b) => a + b, 0);
								    totalValue.innerHTML = totalSum;
								
								    const myChart = new Chart(ctx, {
								        type: 'doughnut',
								        data: {
								            labels: ['요청', '피드백', '보류', '진행', '완료'],
								            datasets: [{
								                data: dataValues,
								                backgroundColor: [
								                    'rgba(0, 178, 255, 1)',
								                    'rgba(253, 121, 0, 1)',
								                    'rgba(119, 119, 119, 1)',
								                    'rgba(0, 176, 28, 1)',
								                    'rgba(64, 42, 157, 1)'
								                ],
								                borderColor: [
								                    'rgba(0, 178, 255, 1)',
								                    'rgba(253, 121, 0, 1)',
								                    'rgba(119, 119, 119, 1)',
								                    'rgba(0, 176, 28, 1)',
								                    'rgba(64, 42, 157, 1)'
								                ],
								                borderWidth: 1
								            }]
								        },
								        options: {
								            responsive: true,
								            plugins: {
								                legend: {
								                    display: false,
								                },
								                tooltip: {
								                    backgroundColor: 'rgba(85, 85, 85, 0.8)',
								                    bodyFontColor: 'white',
								                    borderColor: 'rgba(255, 255, 255, 0.5)',
								                    borderWidth: 1,
								                    displayColors: true,
								                },
								            },
								            animation: {
								                duration: 1000,
								            },
								        }
								    });
								});
								    </script>
									<div class="js-task-report-layer"
										style="display: inline-block;">
										<div class="taks-report">
											<!--display:none-->
											<!-- chart -->
											<div class="donut-chart-area">
												<canvas id="myChart" style="width: 150px; height: 150px"></canvas>
												<div id="chart-total"></div>
											</div>
											<ul id="taskReportLayer" class="donut-chart-list">
												<li><span class="task-chart-info request" data-code="0">
														<i class="chart-info-label"></i> <span
														class="chart-info-text"><span>요청</span><em><%=a%></em></span>
														<span class="chart-info-percent"><%=String.format("%.1f", (double) a / sum * 100)%>%</span>
												</span> <span class="task-chart-info progress" data-code="1">
														<i class="chart-info-label"></i> <span
														class="chart-info-text"><span>진행</span><em><%=b%></em></span>
														<span class="chart-info-percent"><%=String.format("%.1f", (double) b / sum * 100)%>%</span>
												</span></li>
												<li><span class="task-chart-info feedback"
													data-code="4"> <i class="chart-info-label"></i> <span
														class="chart-info-text"><span>피드백</span><em><%=c%></em></span>
														<span class="chart-info-percent"><%=String.format("%.1f", (double) c / sum * 100)%>%</span>
												</span> <span class="task-chart-info complete" data-code="2">
														<i class="chart-info-label"></i> <span
														class="chart-info-text"><span>완료</span><em><%=d%></em></span>
														<span class="chart-info-percent"><%=String.format("%.1f", (double) d / sum * 100)%>%</span>
												</span></li>
												<li><span class="task-chart-info hold" data-code="3">
														<i class="chart-info-label"></i> <span
														class="chart-info-text"><span>보류</span><em><%=e%></em></span>
														<span class="chart-info-percent"><%=String.format("%.1f", (double) e / sum * 100)%>%</span>
												</span></li>
											</ul>
										</div>
									</div>
									<!-- //원형차트 -->
								</div>
							</div>

							<div id="createPostArea" class="work-design-wrapper">
								<ul id="createPostUl" class="work-design-group">
									<li class="post-filter" data-post-code="1"><i
										class="fa-regular fa-file-lines" style="color: #000000;"></i><span>글</span></li>
									<li class="post-filter" data-post-code="4"><i
										class="fa-solid fa-list-ul" style="color: #000000;"></i><span>업무</span></li>
									<li class="post-filter" data-post-code="3"><i
										class="fa-regular fa-calendar" style="color: #000000;"></i><span>일정</span></li>
									<li class="post-filter" data-post-code="2"><i
										class="fa-regular fa-square-check" style="color: #000000;"></i><span>할
											일</span></li>
									<li class="post-filter" data-post-code="6"><i
										class="icons-vote"></i><span>투표</span></li>
								</ul>
								<div class="work-desing-element">
									<p class="work-desing-text">내용을 입력하세요.</p>
									<div class="js-work-icon-group work-icon-group">
										<i class="fa-solid fa-paperclip"></i> <i
											class="fa-regular fa-image"></i> <i
											class="fa-solid fa-location-dot"></i> <i
											class="fa-solid fa-hashtag"></i> <span
											style="font-size: 16px; margin-left: 16px; vertical-align: top; color: #ccc;">@</span>
										<i class="fa-solid fa-t"></i>
									</div>
								</div>
							</div>
						</div>
<!-- 아래 메인 -->
<%
    String sql = "SELECT * FROM employees WHERE employee_id='takein'";

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url, id, pw);
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

%>
					<%
					while (rs.next()){
					%>
						<div id="projectFeedArea" class="detail-section">
						<div class="post-card-header">
                    <div class="post-card-scroll">
                        <div class="card-header-top">
                            <div class="post-author main js-post-author" data-author-id="hkbk00@gmail.com">
                                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
                                <dl class="post-author-info">
                                    <dt>
                                        <strong class="author ellipsis notranslate"><%=rs.getString("employee_name")%></strong>
                                        <em class="position ellipsis" style="display:inline" data=""><%=rs.getString("job_title")%></em>
                                        <span class="date">2023-07-10 13:54</span>
                                        <span class="post-security" style="display:inline" data=""> <i class="fa-solid fa-users" style="color:#aaa"></i></span>
                                    </dt>
                                    <dd class="d-block">
                                        <strong class=""></strong>
                                        <span class="team"></span>
                                    </dd>
                                </dl>
                            </div>
                            <div>
                                <div class="post-option">

                                    <button id="pinToTopBnt" class="js-pin-post fixed-btn js-pin-authority " style="display:block" data="">
                                        <!-- fixed-btn on class -->
                                        <span class="blind">상단 고정 등록</span>
                                    </button>
                                    <button class="js-setting-button set-btn">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </button>
                                    <ul class="js-setting-ul js-setting-layer setup-group d-none">
                                        <li class="js-setting-item" data-code="modify" style="display:block" data="">
                                            <a href="#"> <i class="icons-write"></i>수정
                                                <i class="edit-auth-icon icons-question js-mouseover d-none" mouseover-text="공동 수정 권한이 활성화 되어있습니다." style="display:none" data=""></i>
                                            </a>
                                        </li>
                                        <li class="js-setting-item" data-code="copy" style="display:block" data="">
                                            <a href="#"> <i class="icons-project-1"></i>다른 프로젝트에 복사</a>
                                        </li><li class="js-setting-item" data-code="url" style="display:block" data="">
                                            <a href="#"> <i class="icons-copy"></i>링크 복사</a>
                                        </li>
                                        
                                        <li class="js-setting-item" data-code="delete" style="display:block" data="">
                                            <a href="#"> <i class="icons-delete-3"></i>삭제</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="card-header-bottom">
                            
                            <div class="post-title-area">
                                <h4 class="post-title">asd</h4>
                            </div>
                        </div>
                        <div class="post-card-container">
				        <div id="originalPost" class="post-card-content " style="display:block" contentEditable='false'><div>asd</div></div>
                            <div class="post-bottom-area">
                                <div class="post-bottom-menu js-reaction-bookmark">
                                    <div class="bottom-button-area">
                                        <button class="js-post-reaction post-bottom-button ">
                                            <i class="icon-reaction"></i>
                                            <span>좋아요</span>
                                        </button>
                                        <button class="js-post-bookmark post-bottom-button ">
                                            <i class="icon-bookmark"></i>
                                            <span>북마크</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="cmt-read-wr">
                                    <div class="comment-count-area">
                                        <span>댓글</span>
                                        <span class="comment-count">0</span>
                                    </div>
                                    <div class="js-read-check-button read-confirmation" style="display:block" data="">
                                        <span>읽음</span>
                                        <span class="confirmation-number">1</span>
                                    </div>
                                </div>

                            </div>
                            <!-- //post-card-container -->
                        </div>
                        <div class="post-card-footer">
                            <div class="comment-header">
                            </div>
                            <ul class="post-comment-group"></ul>
                        </div>
                        <div class="js-remark-layer js-edit-layer comment-input-wrap">
                            <div class="comment-thumbnail">
                                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
                            </div>
                            <form class="js-remark-form comment-container on " spellcheck="false">
                                <fieldset>
                                    <legend class="blind">댓글 입력</legend>
                                    <div class="js-remark-area js-paste-layer comment-input" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
			</div>
		</section>
	<!-- 참여자 -->
							<div class="participants-section">
								<div id="projectParticipants"
									class="project-participants-wrap feed-section"
									style="transform: translateX(0px);">
									<div class="section-title-area">
										<h4 class="section-title">
											<span id="participantSpan">참여자</span> <span
												id="participantCount" style="">4</span>
										</h4>
										<div class="feed-type-area">
											<button id="allSendienceBtn" type="button">전체 보기</button>
										</div>
									</div>
									<div id="participantArea" class="participants-container">
										<div id="participantScrollArea"
											class="participants-content-group scroll-mask"
											scroll-direction="0">
											<ul id="participantsUl" class="participants-list">
												<span class="participants-title"><em>프로젝트 관리자</em><span
													id="managerParticipantsCount" class="number-of-participants">2</span></span>
												<li class="js-participant-item" data-id="kakao_2739051431"
													style="display: flex;">
													<div class="post-author">
														<span
															class="js-participant-profile thumbnail size40 radius16"
															style="background-image: url(https://flow.team/flow-renewal/assets/images/profile-default.png), url(https://flow.team/flow-renewal/assets/images/profile-default.png), url(https://flow.team/flow-renewal/assets/images/profile-default.png)"
															data=""></span>
														<dl class="post-author-info">
															<dt>
																<strong class="js-participant-name author ellipsis">정택인</strong>
																<em class="position ellipsis" style="display: none"
																	data=""></em>
		
															</dt>
															<dd style="display: none" data="">
																<strong class="company"></strong> <span class="team"></span>
															</dd>
														</dl>
													</div>
													<button type="button"
														class="js-participant-chat participant-chat-button">
														<i class="fa-regular fa-comment-dots"
															style="font-size: 20px; color: #c4c4c4;"><span
															class="blind">채팅</span></i>
													</button>
												</li>
		
												<li class="js-participant-item" data-id="hkbk00@gmail.com"
													style="display: flex;">
													<div class="post-author">
														<span
															class="js-participant-profile thumbnail size40 radius16"
															style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)"
															data=""></span>
														<dl class="post-author-info">
		
		
		
															<dt>
																<strong class="js-participant-name author ellipsis"><%=rs.getString("employee_name")%>
																	(나) </strong> <em class="position ellipsis" style="display: flex"
																	data=""><%=rs.getString("job_title")%></em>
		
															</dt>
															<dd style="display: flex" data="">
																<strong class="company"><%=rs.getInt("company_id")%></strong> <span class="team"></span>
															</dd>
		
		
														</dl>
													</div>
													<button type="button"
														class="js-participant-chat participant-chat-button">
														<i class="fa-regular fa-comment-dots"
															style="font-size: 20px; color: #c4c4c4;"><span
															class="blind">채팅</span></i>
													</button>
												</li>
												<span class="participants-title"><em>임직원</em><span
													id="innerParticipantsCount" class="number-of-participants">2</span></span>
												<li class="js-participant-item" data-id="brotaek@naver.com"
													style="display: flex;">
													<div class="post-author">
														<span
															class="js-participant-profile thumbnail size40 radius16"
															style="background-image: url(https://flow.team/flowImg/FLOW_202306164724826_992417b7-5bc9-4832-8a1a-621e6baeca16.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306164724826_992417b7-5bc9-4832-8a1a-621e6baeca16.png), url(/flow-renewal/assets/images/profile-default.svg)"
															data=""></span>
														<dl class="post-author-info">
		
		
		
															<dt>
																<strong class="js-participant-name author ellipsis">정택인</strong>
																<em class="position ellipsis" style="display: flex"
																	data=""></em>
		
															</dt>
															<dd style="display: flex" data="">
																<strong class="company"><%=rs.getInt("company_id")%></strong> <span class="team"></span>
															</dd>
		
		
														</dl>
													</div>
													<button type="button"
														class="js-participant-chat participant-chat-button">
														<i class="fa-regular fa-comment-dots"
															style="font-size: 20px; color: #c4c4c4;"><span
															class="blind">채팅</span></i>
													</button>
												</li>
		
												<li class="js-participant-item" data-id="apzkemfht@proton.me"
													style="display: flex;">
													<div class="post-author">
														<span
															class="js-participant-profile thumbnail size40 radius16"
															style="background-image: url(https://flow.team/flowImg/FLOW_202306143136347_8e1cb4c9-75ef-4f36-88b8-287dc483fb9f.jpg?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306143136347_8e1cb4c9-75ef-4f36-88b8-287dc483fb9f.jpg), url(/flow-renewal/assets/images/profile-default.svg)"
															data=""></span>
														<dl class="post-author-info">
															<dt>
																<strong class="js-participant-name author ellipsis">하늘하하늘</strong>
																<em class="position ellipsis" style="display: flex"
																	data=""></em>
															</dt>
															<dd style="display: flex" data="">
																<strong class="company"><%=rs.getInt("company_id")%></strong> <span class="team"></span>
															</dd>
														</dl>
													</div>
													<button type="button"
														class="js-participant-chat participant-chat-button">
														<i class="fa-regular fa-comment-dots"
															style="font-size: 20px; color: #c4c4c4;"><span
															class="blind">채팅</span></i>
													</button>
												</li>
											</ul>
										</div>
										<div class="participants-menu" style="">
		
											<button class="js-project-chat participant-button" onclick="openUrl()">
												<span><i class="icons-chat small"></i>채팅</span>
											</button>
											  <script>
											  // 채팅 서버 열어야함
											  
											  function openUrl() {
												    window.open("https://f239-106-249-191-7.ngrok-free.app/", "_blank", "width=450,height=840");
												  }
												  </script>
											<button class="js-video-chat participant-button">
												<span><i class="icons-video"></i>화상회의</span>
											</button>
										</div>
		
									</div>
									<div id="projectAddtionalArea"
										class="project-additional-features-container"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
<!-- 			검색창 -->
			<div class="search-container" style="display:none;">
				<div id="topSettingBar" class="main-header" style="display: block;">
			        <div class="title-1" style="display: block">"<em id="searchWord">ㅁㄴㅇ</em>" 검색 결과</div>
				        <button id="searchResultClose" type="button" class="close-button">
				        <span class="blind">닫기</span>
			        </button>
			    </div>
			    <div class="project-detail-top clearfix">
		      	  <ul id="searchTab" class="project-detail-menu">
		            <li class="js-tab-item" data-code="total">
		                <a>전체</a>
			            </li>
			            <li class="js-tab-item" data-code="project">
			                <a>프로젝트</a>
			            </li>
			            <li class="js-tab-item" data-code="post">
			                <a>글 · 댓글</a>
			            </li>
			        </ul>
			    </div>
			    <div class="all-search-container">
			    	<div id="searchEventArea" class="all-search-content scroll-mask">
			            <div id="projectSearchArea" class="search-result-group " style="display: block;">
			                <div class="search-title-area" style="display: block;">
			                    <span class="search-result-title">프로젝트</span>
			                    <span id="projectSearchCount" class="search-result-count" style="display: none;">0</span>
			                </div>
			                <ul id="projectSearchResult" class="scroll-mask all-seach-list-type-1" scroll-direction="0">
			                	<div class="js-project-null project-null-t-1">   
			                		<div class="project-null-t-2 ">       
			                			<div class="search-null"></div>       
			                			<span>검색 결과가 없습니다.</span>   
			                		</div>
			                	</div>
			                </ul>
			                <button id="projectSearchMore" type="button" class="js-search-more search-result-more" data-code="project" style="display: none;">더보기
			                </button>
			            </div>
			            <div id="postSearchArea" class="search-result-group" style="display: none;">
			                <div class="search-title-area">
			                    <span class="search-result-title">글 · 댓글</span>
			                    <span id="postSearchCount" class="search-result-count"></span>
			                </div>
			                <ul id="postSearchResult" class="scroll-mask all-seach-list-type-1">
			              		<div class="js-project-null project-null-t-1">   
			                		<div class="project-null-t-2 ">       
			                			<div class="search-null"></div>       
			                			<span>검색 결과가 없습니다.</span>   
			                		</div>
			                	</div>
			                </ul>
			                <button id="postSearchMore" type="button" class="js-search-more search-result-more" data-code="post" style="display: none;">
			                    	더보기
			                </button>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</div>
</div>
	<!--여기 프로필  -->
	<div class="flow-all-background-1 back-area temp-popup" tabindex="0"
		id="tempPopup" style="z-index: 11; display: none;">
		<div class="flow-project-make-1 back-area ">
			<div class="flow-project-make-2 back-area contents">
				<div class="profile-popup js-profile-popup d-none"
					style="display: block;">
					<div class="profile-header">
						<div class="profile-header-dimmed-layer"></div>
						<button class="btn-close icons-close-1" onclick="openPopup12()">
							<i class="fa-solid fa-x" style="color: #000000; font-size: 15px;"></i>
						</button>
					</div>
					<div class="name-card name-badge">
						<i class="profile-image js-profile-image "
							style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)"
							data=""></i>
						<!--프로필 사진 미설정 시 .default 클스 추가-->
						<div class="info profile-badge">
							<p class="info-box">
								<span class="name ellipsis"><%=rs.getString("employee_name")%></span> <span class="position"></span>
							</p>
							<p class="info-badge d-none"></p>
						</div>
					</div>
					<div class="contact-section scroll-mask thin">
						<ul class="contact-contents">
							<li class="company-info"><em><i class="profile-company"></i></em>
								<div>
									<strong><%=rs.getString("employee_name")%></strong> <em></em>
								</div></li>
							<li id="profileEml" style="display: flex" data=""><em><i
									class="profile-mail js-user-email"></i></em> <span><%=rs.getString("employee_id")%></span>
							</li>
							<li id="profileClphNo" class=" " style="display: flex" data="">
								<em><i class="profile-phone js-user-phone"></i></em> 
								<span class="profileClphNo"><%=rs.getString("phone")%></span>
							</li>
							<li id="profileCmpnTlphNo" class="" style="display: flex" data=""
								title=""><em><i class="profile-call js-user-call"></i></em>
								<span class="profileCmpnTlphNo"><%=rs.getString("phone_company")%></span></li>
							<li id="profileSlgn" class="txt" style="display: flex" data="">
								<em><i class="profile-txt icon-txt js-user-txt"></i></em> <span
								 class="scroll-mask thin"><%=rs.getString("status_message")%></span>
							</li>
						</ul>
					</div>
					<%				
					}
						  } catch (ClassNotFoundException | SQLException ex) {
				        ex.printStackTrace();
				    } finally {
				        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
				        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
				        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
				    }
					%>	
					<div class="btn-wr column">
						<button class="btn-chat js-btn-chat">
							<span>채팅</span> <i></i>
						</button>
						<button class="btn-modi js-btn-modi" style="display: flex"
							onclick='openPopup13(),openPopup12()'>
							<span>정보수정</span> <i></i>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--환경설정  -->
	<div id="mySettingPopup" class="flow-all-background-1 zx-9 d-none">

		<div class="flow-project-make-1">
			<div class="flow-project-make-2">
				<div id="innerMySettingPopup" class="my-layer-type-3">
					<div class="my-layer-header">
						<div class="my-layer-header-1">
							<div id="myPicture" class="my-prop-picture"
								style="background-image: url(&quot;https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400&quot;), url(&quot;/flow-renewal/assets/images/profile-default.png&quot;);">
								<a id="editorProfilePhotoBtn" href="#" class="my-button-1"></a>
							</div>
							<span id="accountSetting" class="js-my-setting-title">환경설정</span>
						</div>

						<div id="editorProfilePhoto" class="my-popup-pro-1-1 d-none">
							<a id="changeProfilePhotoBtn" href="#"> <span> <i
									class="icons-picture"></i> 사진 변경
							</span>
							</a> <a id="removeProfilePhotoBtn" href="#"> <span> <i
									class="icons-delete-2"></i> 삭제
							</span>
							</a>
						</div>
						<a href="#" id="mySettingPopupCloseBtn" class="my-button-close-1"
							onclick="openPopup13()"></a>
					</div>
					<div class="my-layer-content">
						<div class="my-left-style">
							<ul class="my-popup-left-header" id="mySettingLeftMenu">
								<li class="js-my-setting-left"><a id="accountSettingBtn"
									href="#"><em class="my-color-type-2"></em><em
										class="my-type-text-2">계정</em></a></li>
								<li class="js-my-setting-left"><a id="preferencesBtn"
									href="#"><em class="my-color-type-1"></em><em
										class="my-type-text-1">알림</em></a></li>
								<li class="js-my-setting-left"><a id="projectSettingBtn"
									href="#"><em class="my-color-type-1"></em><em
										class="my-type-text-1">디스플레이 설정</em></a></li>
								<li class="js-my-setting-left"><a id="deviceManagementBtn"
									href="#"><em class="my-color-type-1"></em><em
										class="my-type-text-1">보안 </em></a></li>
							</ul>
						</div>
						<%
						    String sql1 = "SELECT * FROM employees WHERE employee_id='hkbkbk'";
						
						    try {
						        Class.forName(driver);
						        conn = DriverManager.getConnection(url, id, pw);
						        pstmt = conn.prepareStatement(sql1);
						        rs = pstmt.executeQuery();
						
						%>
						<div class="my-tab-cont">

									<%
							            while (rs.next()) {
							        %>
							<div id="accountSettingLayer"
								class="js-my-scroll-layer my-over-style d-block">
								<div class="my-right-style adjust">
									<ul>
										<li>
											<div class="my-right-list-1">이용중인 버전</div>
											<div id="version" class="my-right-list-2">비즈니스 프로 버전</div>
										</li>
										<li>
											<div class="my-right-list-1">아이디</div> 
											<div id="user_id" class="my-right-list-2"><%=rs.getString("employee_id")%></div>
										</li>
										<li class="edit-input js-flnm-set adjust" id="settingFlnm">
											<div class="my-right-list-1">이름</div>
											<div class="read-mode d-block">
												<div class="js-user-name my-right-list-2"><%=rs.getString("employee_name")%></div>
											</div> <a href="#" class="poly-icon-1 change-editor-btn"></a>
											<div class="editor-mode d-none">
												<div class="my-right-list-2 my-type-text-1">
													<input id="editor_user_name" type="text" maxlength="20"
														autocomplete="off" data-required-yn="Y" data-valid="name"
														data-empty-msg="이름을 입력해주세요!"
														data-un-valid-msg="특수문자를 사용할 수 없습니다"> <span
														id="error-message" class="error-message"
														style="display: none; color: red;"></span>
													<div class="btn-fr-wrap">
														<a href="#">
															<div class="my-button-cc cancel-change">취소</div>
														</a> <a href="#">
															<div
																class="js-account-set-button js-account-set-button my-button-ok change-ok">
																확인</div>
														</a>
													</div>
												</div>
											</div>
										</li>
										<li class="edit-input js-company-set adjust" id="settingCmnm">
											<div class="my-right-list-1">회사명</div>
											<div class="read-mode d-block">
												<div id="companyName" class="my-right-list-2"><%=rs.getString("employee_id")%></div>
											</div>
										</li>

										<li class="edit-input js-dvsn-set adjust" id="settingDvsn">
											<div class="my-right-list-1">부서</div>
											<div class="read-mode d-block">
												<div id="dvsnName" class="my-right-list-2"><%=rs.getInt("department_id")%></div>
											</div>
										</li>
										<li class="edit-input js-jbcl-set adjust" id="settingJbcl">
											<div class="my-right-list-1">직책</div>
											<div class="read-mode d-block">
												<div id="position" class="js-position-name my-right-list-2"><%=rs.getString("job_title")%></div>
												<a href="#" class="poly-icon-1 change-editor-position-btn"></a>
											</div>
											<div class="editor-mode d-none">
												<div class="my-right-list-2 my-type-text-1">
													<input id="editor_position" type="text" autocomplete="off"
														maxlength="50">
													<div class="btn-fr-wrap">
														<a href="#">
															<div class="my-button-cc cancel-position-change">취소</div>
														</a> <a href="#">
															<div
																class="js-position-set-button my-button-ok change-position-ok">확인</div>
														</a>
													</div>
												</div>
											</div>
										</li>
										<li class="edit-input js-clph-no-set adjust"
											id="settingClphNo" style="display: flex;">
											<div class="my-right-list-1">휴대폰 번호</div>
											<div class="read-mode d-block">
												<div id="phoneNum" class="js-phone-number my-right-list-2"><%=rs.getString("phone")%></div>
												<a href="#" class="poly-icon-1 change-editor-btn"></a>
											</div>
											<div class="editor-mode d-none">
												<div class="my-right-list-2 my-type-text-1">
													<input id="editor_phoneNum" type="text" autocomplete="off"
														data-valid="phoneNumber" maxlength="20"
														placeholder="숫자와  -만 입력 가능합니다"
														data-un-valid-msg="전화번호 형식이 맞지 않습니다."
														style="min-width: 150px;"> <span
														id="error-message" class="error-message"
														style="display: none; color: red;"></span>
													<div class="btn-fr-wrap">
														<a href="#">
															<div class="my-button-cc cancel-change">취소</div>
														</a> <a href="#">
															<div class="js-account-set-button my-button-ok change-ok">확인</div>
														</a>
													</div>
												</div>
											</div>
										</li>
										<li class="edit-input js-cmpn-tlph-no-set adjust" id="settingCmpnTlphNo" style="display: flex;">
										  <div class="my-right-list-1">회사 연락처</div>
										    <div class="read-mode d-block">
										      <div id="companyPhoneNum" class="js-phone-number my-right-list-2"><%=rs.getString("phone_company")%></div>
										      <a href="#" class="poly-icon-1 change-editor-btn"></a>
										    </div>
										    <div class="editor-mode d-none">
										      <div class="my-right-list-2 my-type-text-1">
										        <input id="editor_phoneNum1" type="text" autocomplete="off"
										          data-valid="phoneNumber" maxlength="20"
										          placeholder="숫자와  -만 입력 가능합니다"
										          data-un-valid-msg="전화번호 형식이 맞지 않습니다."
										          style="min-width: 150px;"> <span
										          id="error-message1" class="error-message"
										          style="display: none; color: red;"></span>
										        <div class="btn-fr-wrap">
										          <a href="#">
										            <div class="my-button-cc cancel-change">취소</div>
										          </a>
										          <a href="#">
										            <div class="js-account-set-button my-button-ok change-ok second">확인</div>
										          </a>
										        </div>
										      </div>
										    </div>
										</li>
										<li class="edit-input js-email-set adjust" id="settingEml"
											style="display: flex;">
											<div class="my-right-list-1">이메일</div>
											<div class="read-mode d-block">
												<div id="email" class="my-right-list-2"><%=rs.getString("employee_id")%></div>

											</div>
										</li>

										<li class="edit-input adjust password" id="passwordArea"
											style="display: flex;">
											<div class="my-right-list-1">비밀번호</div>
											<div class="read-mode d-block">
												<div class="my-right-list-password">
													<strong class="password-alert">비밀번호 재설정이 가능합니다.</strong> <input
														type="password" id="normalPasswordInput"
														class="my-input-password-1 d-none" disabled=""
														placeholder="비밀번호 입력 (8~20자 영문, 숫자, 특수문자 조합)"
														style="display: flex;">
													<button class="js-myset-password change-editor-btn">비밀번호
														재설정</button>
												</div>
											</div>
											<div class="editor-mode d-none">
												<ul>
													<li>
														<div class="my-right-list-1">비밀번호 재설정</div>
														<div class="my-right-list-2 edit-password">
															<a href="#"></a><span class="my-txt-t-1">비밀번호는 영문,
																숫자, 특수문자 포함 8자리 이상이어야 합니다.</span>
														</div>
													</li>
													<li>
														<div class="my-right-list-1"></div>
														<div class="my-right-list-2">
															<span class="edit-tit">현재 비밀번호</span> <input
																type="password" id="currentPassword"
																class="my-input-password-2" style="margin-left: 5px"
																autocomplete="off" data-required-yn="Y" maxlength="20"
																data-valid="password" data-empty-msg="비밀번호를 입력해주세요"
																data-over-msg="20자 이내로 입력하세요."
																data-un-valid-msg="비밀번호는 8~20자의 영문, 숫자, 특수문자를 포함해야 합니다."
																placeholder="현재 비밀번호를 입력해주세요">
														</div>
													</li>
													<li>
														<div class="my-right-list-1"></div>
														<div class="my-right-list-2">
															<span class="edit-tit">새 비밀번호</span> <input
																type="password" id="myPassword"
																class="my-input-password-2" style="margin-left: 8px"
																autocomplete="off" data-required-yn="Y" maxlength="20"
																data-valid="password" data-empty-msg="비밀번호를 입력해주세요"
																data-over-msg="20자 이내로 입력하세요."
																data-un-valid-msg="비밀번호는 8~20자의 영문, 숫자, 특수문자를 포함해야 합니다."
																placeholder="새 비밀번호를 입력해주세요">
														</div>
													</li>
													<li>
														<div class="my-right-list-1"></div>
														<div class="my-right-list-2">
															<span class="edit-tit">비밀번호 확인</span> <input
																type="password" class="my-input-password-2"
																style="margin-left: 5px" id="myPassword2"
																autocomplete="off" data-required-yn="Y" maxlength="20"
																data-valid="password" data-empty-msg="비밀번호를 입력해주세요"
																data-over-msg="20자 이내로 입력하세요."
																data-un-valid-msg="비밀번호는 8~20자의 영문, 숫자, 특수문자를 포함해야 합니다."
																placeholder="비밀번호를 다시 입력해주세요">
														</div>
													</li>
													<li>
														<div class="btn-fr-wrap password-btn-fr-wrap">
															<a href="#">
																<div id="changePasswordCancel" class="my-button-cc">취소</div>
															</a><a href="#">
																<div id="changePasswordBtn" class="my-button-ok">확인</div>
															</a>
														</div>
													</li>
												</ul>
											</div>
										</li>
										<%				
										}
											  } catch (ClassNotFoundException | SQLException ex) {
									        ex.printStackTrace();
									    } finally {
									        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
									        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
									        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
									    }
										%>

										<li class="edit-input js-slgn-set adjust" id="settingSlgn"
											style="display: flex;">
											<div class="my-right-list-1">상태 메시지</div>
											<div class="read-mode d-block">
												<div id="statusMessage"
													class="my-right-list-2 status-message"></div>

											</div> <a href="#" class="poly-icon-1 change-editor-btn"></a>
										</li>
									</ul>
									<div class="setting-layer-bottom-wrap clearFix">

										<button id="marketingAgreementBtn"
											class="btn-setting-layer-bottom">혜택 알림 동의 변경</button>

										<button id="leaveFlowBtn" class="btn-setting-layer-bottom"
											style="display: none;">탈퇴</button>
									</div>
								</div>
							</div>

							<div id="preferencesLayer"
								class="alarmSet js-my-scroll-layer my-over-style d-none">
								<div class="my-right-style">
									<ul id="pushAlamGroup" class="push-alarm-group">
										<li class="bd-none">
											<div class="my-right-list-1">푸시</div>
											<div class="my-right-list-2">
												<div>
													새로운 글, 댓글, 채팅의 실시간 알림을 받습니다.
													<button type="button" id="pushAlamSetting"
														class="toggle-button my-check-1">
														<!-- active 클래스로 제어  -->
														<i class="handle"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2">
												프로젝트 알림<a href="#">
													<div id="projectAlamSetting" class="my-check-2"></div>
												</a>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2">
												채팅 알림<a href="#">
													<div id="chatAlamSetting" class="my-check-2"></div>
												</a>
											</div>
										</li>


									</ul>
									<ul id="doNotDisturbGroup" class="disturb-group">
										<li class="bd-none">
											<div class="my-right-list-1">방해 금지 모드</div>
											<div class="my-right-list-2">
												선택한 요일과 시간에 알림을 받지 않습니다.
												<button type="button" id="doNotDisturbSetting"
													class="toggle-button my-check-1">
													<!-- active 클래스로 제어  -->
													<i class="handle"></i>
												</button>
											</div>
										</li>
										<li>
											<div class="my-right-list-1" id="notDisturbDailyEmpty"></div>
											<div class="my-right-list-2 sp-between disturb-day"
												id="notDisturbDailyList">
												<span>요일</span>
												<div id="doNotDisturbDayby">
													<ul class="my-dayby-w-1">
														<li id="0dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">일</a></li>
														<li id="1dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">월</a></li>
														<li id="2dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">화</a></li>
														<li id="3dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">수</a></li>
														<li id="4dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">목</a></li>
														<li id="5dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">금</a></li>
														<li id="6dayOfTheWeek" class="my-dayby-1 day-of-the-week"><a
															href="#">토</a></li>
													</ul>
												</div>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2 sp-between select-box-wrap">
												시간
												<div class="sp-between" style="width: 350px;">
													<select id="doNotDisturbStartTime" class="my-type-1">
														<option>00:00</option>
														<option>01:00</option>
														<option>02:00</option>
														<option>03:00</option>
														<option>04:00</option>
														<option>05:00</option>
														<option>06:00</option>
														<option>07:00</option>
														<option>08:00</option>
														<option>09:00</option>
														<option>10:00</option>
														<option>11:00</option>
														<option>12:00</option>
														<option>13:00</option>
														<option>14:00</option>
														<option>15:00</option>
														<option>16:00</option>
														<option>17:00</option>
														<option>18:00</option>
														<option>19:00</option>
														<option>20:00</option>
														<option>21:00</option>
														<option>22:00</option>
														<option>23:00</option>
														<option>24:00</option>
													</select> <span class="my-mk-1">~</span> <select
														id="doNotDisturbEndTime" class="my-type-1">
														<option>00:00</option>
														<option>01:00</option>
														<option>02:00</option>
														<option>03:00</option>
														<option>04:00</option>
														<option>05:00</option>
														<option>06:00</option>
														<option>07:00</option>
														<option>08:00</option>
														<option>09:00</option>
														<option>10:00</option>
														<option>11:00</option>
														<option>12:00</option>
														<option>13:00</option>
														<option>14:00</option>
														<option>15:00</option>
														<option>16:00</option>
														<option>17:00</option>
														<option>18:00</option>
														<option>19:00</option>
														<option>20:00</option>
														<option>21:00</option>
														<option>22:00</option>
														<option>23:00</option>
														<option>24:00</option>
													</select>
												</div>
											</div>
										</li>
									</ul>
									<ul class="js-mail-set-ul email-alarm-set">
										<li class="bd-none">
											<div class="my-right-list-1">
												이메일 알림 <a
													href="https://support.flow.team/hc/ko/articles/7578317732377"
													target="_blank"><i class="question-mark"></i></a>



											</div>
											<div class="my-right-list-2 js-email">hkbk00@gmail.com</div>


										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2 js-mail-set-text">
												누군가가 나를 @멘션 합니다.
												<button type="button" id="mentionMailButton"
													class="js-mail-set-button toggle-button my-check-1"
													mail-set-type="mail_mention">
													<i class="handle"></i>
												</button>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2 js-mail-set-text">
												누군가가 내게 업무를 배정합니다.
												<button type="button" id="workerMailButton"
													class="js-mail-set-button toggle-button my-check-1"
													mail-set-type="mail_worker">
													<i class="handle"></i>
												</button>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2 js-mail-set-text">
												내가 요청한 업무의 상태가 변경되었습니다.
												<button type="button" id="taskMailButton"
													class="js-mail-set-button toggle-button my-check-1"
													mail-set-type="mail_task">
													<i class="handle"></i>
												</button>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div
												class="my-right-list-2 js-mail-set-text weekly-report-icon">
												주간 리포트
												<button id="weekReportMailButton"
													class="js-mail-set-button toggle-button my-check-1"
													mail-set-type="mail_week_report" type="button">
													<i class="handle"></i>
												</button>
											</div>
										</li>
									</ul>
								</div>
							</div>

							<div id="deviceManagementLayer"
								class="securitySet js-my-scroll-layer my-over-style d-none">
								<div class="my-right-style-9">
									<div class="my-right-style">
										<ul class="lock-list">
											<li class="bd-none">
												<div class="my-right-list-1">자동 로그아웃</div>
												<div class="my-right-list-2 sp-between">
													설정한 시간 동안 사용하지 않으면 로그아웃 됩니다.
													<button type="button" id="lockModeSetting"
														class="toggle-button my-check-1">
														<!-- active 클래스로 제어  -->
														<i class="handle"></i>
													</button>
												</div>
											</li>
											<li>
												<div class="my-right-list-1"></div>
												<div class="my-right-list-2 sp-between">
													시간 설정 <select id="lockTime" class="my-type-4">
														<option value="1">1분 후</option>
														<option value="5">5분 후</option>
														<option value="10">10분 후</option>
														<option value="30">30분 후</option>
														<option value="60">1시간 후</option>
														<option value="120">2 시간 후</option>
														<option value="180">3 시간 후</option>
														<option value="240" selected="">4 시간 후</option>
														<option value="300">5 시간 후</option>
													</select>
												</div>
											</li>
										</ul>
										<ul>
											<li class="bd-none">
												<div class="my-right-list-1">접속기기 관리</div>
												<div class="my-right-list-2 sp-between">
													<ul id="deviceList" class="my-right-data d-none">
														<li class="sp-between">
															<div>
																<p class="data-position-fix-1">
																	<b> {DUID_NM}</b>
																</p>
																<p class="data-color-type-1">
																	<b>마지막 사용</b><span> {LAST_DATE}</span>
																</p>
																<p class="data-color-type-1">
																	<b>최초 등록일</b><span> {FIRST_DATE}</span>
																</p>
															</div>
															<div>
																<a id="removeDevice" duid="{DUID}" href="#"
																	class="data-delete-button-1 remove-btn {DISPLAY_REMOVE}">
																	<div>삭제</div>
																</a>
																<div class="wifi-icon-wrap-1 {DISPLAY_CURRENT}">
																	<div class="wifi-icon-1"></div>
																	<span>현재 접속기기</span>
																</div>
															</div>
														</li>
													</ul>

												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>

							<div id="projectSettingsLayer"
								class="js-my-scroll-layer my-over-style d-none">
								<div class="my-right-style">

									<ul>
										<li class="bd-none">
											<div class="my-right-list-1">테마</div>
											<div class="my-right-list-2">좌측 메뉴의 컬러 테마를 지정하실 수 있습니다.</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div id="themeSetting" class="my-right-list-2 set-theme">
												<div class="my-right-check-dark">
													<div class="my-right-check-dark-icon"></div>
													<p>다크</p>
													<div id="darkThemeSetting"
														class="my-check-2 theme-posion-fix" style="right: 50%;"></div>
												</div>
												<div class="my-right-check-light">
													<div class="my-right-check-light-icon"
														style="margin-left: 50px;"></div>
													<p>라이트</p>
													<div id="lightThemeSetting"
														class="my-check-2 theme-posion-fix" style="right: 0%;"></div>
												</div>
											</div>
										</li>
									</ul>

									<ul>
										<li class="bd-none">
											<div class="my-right-list-1">프로젝트 색상</div>
											<div class="my-right-list-2">프로젝트 만들기 또는 초대 받았을때, 프로젝트의
												색상을 지정합니다.</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2 sp-between">
												랜덤으로 설정 <a href="#">
													<div id="randomColorSetting" class="my-check-2"></div>
												</a>
												<ul class="my-control-wrap-1" style="margin-right: 30px;">
													<li class="color-code-0"></li>
													<li class="color-code-1"></li>
													<li class="color-code-2"></li>
													<li class="color-code-3"></li>
													<li class="color-code-4"></li>
													<li class="color-code-5"></li>
													<li class="color-code-6"></li>
													<li class="color-code-7"></li>
													<li class="color-code-8"></li>
													<li class="color-code-9"></li>
													<li class="color-code-10"></li>
													<li class="color-code-11"></li>
												</ul>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2 sp-between">
												흰색으로 고정 <a href="#">
													<div id="whiteColorSetting" class="my-check-2"></div>
												</a>
												<div class="my-control-wrap-1">
													<div class="my-control-12"></div>
												</div>
											</div>
										</li>
									</ul>
									<ul>
										<li class="my-setting-favorite-project bd-none">
											<div class="my-right-list-1">프로젝트 즐겨찾기</div>
											<div class="my-right-list-2 sp-between">
												프로젝트 즐겨찾기 시, 상단에 고정하도록 설정할 수 있습니다. <span id="starResetBtn"
													class="btn-reset"><a href="#"
													class="my-right-icon-type-1"></a>초기화</span>
											</div>
										</li>
										<li>
											<div class="my-right-list-1"></div>
											<div class="my-right-list-2">
												즐겨찾기 사용 <a href="#">
													<div id="useFavoritesSetting" class="my-check-2"></div>
												</a>
											</div>
										</li>
										<li><div class="my-right-list-1"></div>
											<div class="my-right-list-2">
												즐겨찾기 사용안함 <a href="#"><div id="notUseFavoritesSetting"
														class="my-check-2"></div></a>
											</div></li>
									</ul>
								</div>
							</div>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
	<div class="flow-all-background-1 back-area temp-popup1 d-none"
		style="background: rgba(0, 0, 0, 0.6); z-index: 10;">
		<div class="confirm-popup flow-project-popup-6 d-block">
			<div class="flow-content">
				<div class="flow-content-text">
					<p class="popup-cont">
						프로젝트 즐겨찾기를 초기화 하시겠습니까?<br>(복구 되지 않습니다)
					</p>
				</div>
				<div class="flow-pop-button-type-1">
					<div class="flow-pop-sub-button-1 cancel-event"
						style="cursor: pointer;">취소</div>
					<div class="flow-pop-sub-button-2 submit-event"
						style="cursor: pointer;">확인</div>
				</div>
			</div>
		</div>
	</div>
	<div class="flow-all-background-1 back-area temp-popup2 d-none"
		style="background: rgba(0, 0, 0, 0.6); z-index: 10;">
		<div class="input-popup flow-project-popup-4" style="display: block;">
			<div class="flow-project-header-1">
				<span class="popup-title">프로젝트 폴더 만들기</span>
			</div>
			<div class="flow-content">
				<div class="flow-content-input-1">
					<input class="popup-input" type="text"
						placeholder=" 프로젝트 폴더명을 입력하세요" maxlength="50" data-required-yn="Y"
						data-empty-msg="" data-over-msg="프로젝트 폴더명을 50자 이하로 입력해주세요.">
				</div>
				<div class="flow-pop-button-type-1">
					<div class="flow-pop-sub-button-1 cancel-event1"
						style="cursor: pointer;">취소</div>
					<div class="flow-pop-sub-button-2 submit-event1"
						style="cursor: pointer;">확인</div>
				</div>
			</div>
		</div>
	</div>
	<div class="flow-all-background-1 back-area temp-popup3 d-none"
		style="background: rgba(0, 0, 0, 0.6); z-index: 10;">
		<div id="firstInvitePopup"
			class="js-invite-employee-layer popup-notice-employee"
			style="display: block;">
			<div class="contents">
				<strong class="tit">직원 초대</strong> <a
					class="close-invite-layer-btn js-close-btn" href="#"><em></em></a>
				<p class="txt">직원들과 협업을 시작해보세요.</p>
				<img
					src="https://flow.team/flow-renewal/assets/images/invite_url.png">
				<div class="url-area" style="margin-bottom: 0px;">
					<input class="invite-url js-link-text" disabled="">
					<button id="copyLinkBtn" type="button" class="copy-url-button">
						초대장 복사</button>
				</div>
				<a id="otherInviteBtn" class="other-invite" style="display: block;">다른
					방법으로 초대하기 (이메일, 엑셀 등록)</a>
			</div>
			<div id="popupBottom" class="bottom" style="display: none;">
				<div id="notViewToday" class="check-box">
					<input type="checkbox" id="chk3"> <label for="chk3"></label>
					오늘 하루 다시 보지 않기
				</div>
			</div>
		</div>
	</div>
	<div class="flow-all-background-1 color-popup d-none">
		<div class="color-popup flow-project-popup-3">
			<div class="flow-project-header-1">
				프로젝트 색상<a class="cursor-pointer close-event flow-close-type-1"></a>
			</div>
			<div class="flow-content">
				<div class="flow-category-option-3">
					<ul id="selectColorTypes" class="select-color-group">
						<li class="color-item color-code-5"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-11"><a
							class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-1 project-color-check-active-1"><a
							class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-10"><a
							class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-2"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-7"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-9" style="margin-left: 0px;"><a
							class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-6"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-3"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-4"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-8"><a class="cursor-pointer"><em></em></a></li>
						<li class="color-item color-code-0"><a class="cursor-pointer"><em></em></a></li>
					</ul>
				</div>
				<div class="flow-pop-button-type-1 margin-bottom-20">
					<button type="button" class="flow-pop-sub-button-1 cancel-event">취소</button>
					<button type="button" class="color flow-pop-sub-button-2 submit-event">확인</button>
				</div>
			</div>
		</div>
	</div>
	<div class="flow-all-background-1 label-popup d-none">
		<div class="label-popup allProjLabel-popup flow-project-popup-8">
			<div class="flow-project-header-1">
				<span>프로젝트 폴더 설정</span> <a
					class="cursor-pointer close-event flow-close-type-1"></a>
			</div>
			<ul class="js-label-ul label-set-group scroll-mask">
				<li class="label-item" data-label-kind="3" data-label-srno="6"
					data-label-ico="">
					<div class="label-set-item" style="margin-top: 15px;">
						<span class="label-item-text ellipsis">ㅁㄴㅇㅁㄴㅇㅁ</span> <a href="#"
							class="js-check-label flow-content-check-type-1"></a>
					</div>
				</li>

				<li class="label-item" data-label-kind="3" data-label-srno="5"
					data-label-ico="">
					<div class="label-set-item">
						<span class="label-item-text ellipsis">asd</span> <a href="#"
							class="js-check-label flow-content-check-type-1"></a>
					</div>
				</li>

				<li class="label-item" data-label-kind="3" data-label-srno="4"
					data-label-ico="">
					<div class="label-set-item">
						<span class="label-item-text ellipsis">aa</span> <a href="#"
							class="js-check-label flow-content-check-type-1"></a>
					</div>
				</li>

				<li class="label-item" data-label-kind="3" data-label-srno="1"
					data-label-ico="4">
					<div class="label-set-item">
						<span class="label-item-text ellipsis">마케팅</span> <a href="#"
							class="js-check-label flow-content-check-type-1"></a>
					</div>
				</li>

				<li class="label-item" data-label-kind="3" data-label-srno="2"
					data-label-ico="9">
					<div class="label-set-item">
						<span class="label-item-text ellipsis">디자인</span> <a href="#"
							class="js-check-label flow-content-check-type-1"></a>
					</div>
				</li>

				<li class="label-item" data-label-kind="3" data-label-srno="3"
					data-label-ico="1">
					<div class="label-set-item">
						<span class="label-item-text ellipsis">엔지니어링</span> <a href="#"
							class="js-check-label flow-content-check-type-1"></a>
					</div>
				</li>
			</ul>
			<script>
			// 태그 선택
			var linkElement = document.querySelector('.js-check-label.flow-content-check-type-1');

			// 이벤트 리스너 함수 생성
			function toggleLink(event) {
			  event.preventDefault();

			  // 클래스 변경
			  if (linkElement.classList.contains('flow-content-check-type-1')) {
			    linkElement.classList.remove('flow-content-check-type-1');
			    linkElement.classList.add('flow-content-check-type-2');
			  } else {
			    linkElement.classList.remove('flow-content-check-type-2');
			    linkElement.classList.add('flow-content-check-type-1');
			  }
			}

			// 이벤트 리스너 추가
			linkElement.addEventListener('click', toggleLink);
			</script>
			<div class="flow-pop-button-type-2">
				<a class="cursor-pointer">
					<div class="flow-pop-sub-button-1 cancel-event">취소</div>
				</a> <a class="cursor-pointer">
					<div class="flow-pop-sub-button-2 submit-event">확인</div>
				</a>
			</div>
		</div>
	</div>
	<!-- 게시물 작성! -->
	<div class="flow-all-background-1 js-popup-before d-none">
		<div class="js-popup-before edit-item create-post-wrap js-pop-contents js-editor "
			data-code="ADD">
			<div class="create-post-header ">
				<div class="temp-wrap">
					<h4 class="js-create-post-title create-post-title">게시물 작성</h4>
					<div id="selectProjectButton" class="temp-tit-wrap"
						style="display: flex" data="">
						<i id="postArrowIcon" class="icon_arrow_dwn_55"
							style="display: block" data=""></i>
						<div id="postProjectColor" class="squre-type color-code-1"></div>
						<p id="postProjectTitle" class="temp-tit" style="margin: 0;">Yo!</p>
					</div>
				</div>
				<button type="button" class="btn-close">
					<a class="cursor-pointer close-event flow-close-type-1"
						style="width: 15px; height: 15px;"><span class="blind">닫기</span></a>
				</button>
			</div>
			<ul class="js-post-nav create-post-nav write2 ">
				<li class="js-post-type-item " data-post-code="1"><button
						type="button" class="create-tab tab-write2 active" role="tab">
						<i class="fa-regular fa-file-lines"></i><span>글</span>
					</button></li>
				<li class="js-post-type-item" data-post-code="4"><button
						type="button" class="create-tab tab-task" role="tab">
						<i class="fa-solid fa-list-ul"></i><span>업무</span>
					</button></li>
				<li class="js-post-type-item" data-post-code="3"><button
						type="button" class="create-tab tab-schedule" role="tab">
						<i class="fa-regular fa-calendar"></i><span>일정</span>
					</button></li>
				<li class="js-post-type-item" data-post-code="2"><button
						type="button" class="create-tab tab-todo" role="tab">
						<i class="fa-regular fa-square-check"></i><span>할 일</span>
					</button></li>
				<li class="js-post-type-item" data-post-code="6"><button
						type="button" class="create-tab tab-vote" role="tab">
						<i class="icons-vote" style="display: inline-block;"></i><span>투표</span>
					</button></li>
			</ul>
			<div class="create-post-container scroll-mask">
				<div>
					<fieldset>
						<div class="">
							<input id="postTitle" type="text" title="제목을 입력하세요"
								placeholder="제목을 입력하세요." autocomplete="off" data-required-yn="Y"
								class="js-post-title create-title-input" maxlength="100" value="">
						</div>
						<div class="all-option">
						<div class="js-task-option" style="display:none;">
							<ul class="create-content-group">
								<li class="js-status-layer">
									<div class="create-content-cell title">
										<i class="icon-post-status"></i>
									</div>
									<div class="create-content-cell">
										<div class="js-task-state state-button-group clearfix request">
											<button type="button" class="task-state-button request">요청</button>
											<button type="button" class="task-state-button progress">진행</button>
											<button type="button" class="task-state-button feedback">피드백</button>
											<button type="button" class="task-state-button completion">완료</button>
											<button type="button" class="task-state-button hold">보류</button>
										</div>
									</div>
								</li>
								<li class="js-task-worker-layer js-more-task-li"
									style="display: flex" data="">
									<div class="create-content-cell title manager">
										<i class="icon-post-worker"></i>
									</div>
									<div class="create-content-cell manager-btn-group">
										<div class="user-wrap">
											<span class="js-workers manager-group"> </span> <input
												type="text" class="js-worker-input worker-search-input"
												placeholder="담당자 추가" style="display: inline-block;">
										</div>
										<button type="button"
											class="js-worker-button add-manager-button"
											style="display: none;">담당자 추가</button>
									</div>
								</li>
								<script>
								const input = document.querySelector(".js-worker-input");
								const workerGroup = document.querySelector(".js-workers");

								input.addEventListener("keydown", (event) => {
								  if (event.key === "Enter" || event.keyCode === 13) {
								    event.preventDefault();
								    
								    const name = event.target.value;
								    document.querySelector(".js-worker-input").style.display="none";
								    const workerItem = document.createElement("div");
								    workerItem.classList.add("js-registration", "manager-item");
								    workerGroup.appendChild(workerItem);

								    const nameText = document.createTextNode(name);
								    workerItem.appendChild(nameText);

								    const removeButton = document.createElement("button");
								    removeButton.type = "button";
								    removeButton.classList.add("js-remove-worker", "remove-button");
								    removeButton.addEventListener("click", () => {
								      workerGroup.removeChild(workerItem);
								      document.querySelector(".js-worker-input").style.display="block";
								    });
								    workerItem.appendChild(removeButton);

								    event.target.value = "";
								  }
								});
								</script>
								<li class="js-date-layer js-start-date-layer js-more-task-li"
									style="display: none;" data="">
									<div class="create-content-cell title">
										<i class="fa-regular fa-calendar"
											style="color: #000000; font-size: 20px;"></i>
									</div>
									<div class="js-date-option create-content-cell">
										<div class="js-pickr-layer js-start-flatpickr">
											<label type="button" class="js-date-label add-manager-button"
												style="display: flex"> 
												<input id="datepicker3" type="text" placeholder="시작일 추가" readonly="readonly" value="">
											</label>
											<div class="js-date-back-layer date-bg" style="display: none">
												<span class="js-pickr-text task-date"> </span>
												<button type="button" class="js-remove-date remove-button"></button>
											</div>
										</div>
									</div>
								</li>
								<li class="js-date-layer js-end-date-layer js-more-task-li"
									style="display: none;" data="">
									<div class="create-content-cell title">
										<i class="fa-regular fa-calendar"
											style="color: #000000; font-size: 20px;"></i>
									</div>
									<div class="js-date-option create-content-cell">
										<div class="js-pickr-layer js-end-flatpickr">
											<label type="button" class="js-date-label add-manager-button"
												style="display: inline-block"> 
												<input id="datepicker4" type="text" placeholder="마감일 추가" readonly="readonly"	value="">
											</label>
											<div class="js-date-back-layer date-bg d-none"
												style="display: none" data="">
												<span class="js-pickr-text task-date "> <span
													class="js-date-text"></span>
												</span>
												<button type="button" class="js-remove-date remove-button"></button>
											</div>
										</div>
									</div>
								</li>
								<li class="js-priority-layer js-more-task-li"
									style="display: none;" data="">
									<div class="create-content-cell title">
										<i class="fa-regular fa-flag"
											style="color: #000000; font-size: 20px;"></i>
									</div>
									<div class="js-priority create-content-cell" data-priority="">
										<button id="priorityButton" type="button"
											class="js-priority-button js-priority-event add-manager-button"
											style="display: inline-block; padding: 0;" data="">우선순위
											추가</button>
										<div id="prioritySpan"
											class="js-priority-span js-priority-event rank-item"
											style="display: none" data="">
											<i class="icons- small"></i> <span class="js-priority-text"></span>
											<button type="button"
												class="js-remove-priority remove-button"></button>
										</div>
										<div
											class="js-priority-setting-layer js-priority-event priority-group main"
											style="display: none;">
											<button type="button"
												class="js-priority-setting-button priority-button main"
												data-priority-code="low">
												<span> <i class="fa-solid fa-arrow-down"
													style="color: color: #777;"></i>
												</span>낮음
											</button>
											<button type="button"
												class="js-priority-setting-button priority-button main"
												data-priority-code="normal">
												<span> <span
													style="width: 12px; font-weight: 800; color: #60c000;">ㅡ</span>
												</span>보통
											</button>
											<button type="button"
												class="js-priority-setting-button priority-button main"
												data-priority-code="high">
												<span> <i class="fa-solid fa-arrow-up"
													style="color: #ff7d04;"></i>
												</span>높음
											</button>
											<button type="button"
												class="js-priority-setting-button priority-button main"
												data-priority-code="argent">
												<span> <i class="fa-solid fa-tower-broadcast"
													style="color: #ec1e1e;"></i>
												</span>긴급
											</button>
										</div>
									</div>
								</li>
								<li class="js-section-layer" style="display: none;"
									data-section-srno="0" data-section-uptask-yn="Y"
									data-section-list-cnt="101">
									<div class="create-content-cell title">
										<i class="icon-section"></i>
									</div>
									<div
										class="js-section js-section-input section-search-input create-content-cell add-section-cell"
										data-section-srno="0" style="display: inline-block" data="">그룹
										추가</div>
									<div class="js-section js-section-back-layer date-bg"
										style="display: none" data="">
										<span class="js-section-text task-date">0</span>
										<button type="button" class="js-remove-section remove-button"
											style="display: inline-block" data=""></button>
									</div>
									<div
										class="js-section-popup js-section-select-layer section-select-popup js-grid-event all-seach-popup-type-2"
										style="display: none;" tabindex="0">
										<div class="all-seach-section-wrap-3 scroll-mask">
											<ul></ul>
										</div>
									</div>
								</li>
								<li class="js-progress-layer js-more-task-li"
									style="display: none;" data="">
									<div class="create-content-cell title">
										<i class="icon-post-progress"></i>
									</div>
									<div class="js-progress create-content-cell">
										<div class="js-progress-bar progress-graph-bar"
											style="width: 0%" =""="" data-progress="0"></div>
										<div class="progress-graph">
											<span class="progress-button" data-progress-value="0"
												onclick="updateProgress(0)"><em>0%</em></span> <span
												class="progress-button" data-progress-value="10"
												onclick="updateProgress(10)"><em>10%</em></span> <span
												class="progress-button" data-progress-value="20"
												onclick="updateProgress(20)"><em>20%</em></span> <span
												class="progress-button" data-progress-value="30"
												onclick="updateProgress(30)"><em>30%</em></span> <span
												class="progress-button" data-progress-value="40"
												onclick="updateProgress(40)"><em>40%</em></span> <span
												class="progress-button" data-progress-value="50"
												onclick="updateProgress(50)"><em>50%</em></span> <span
												class="progress-button" data-progress-value="60"
												onclick="updateProgress(60)"><em>60%</em></span> <span
												class="progress-button" data-progress-value="70"
												onclick="updateProgress(70)"><em>70%</em></span> <span
												class="progress-button" data-progress-value="80"
												onclick="updateProgress(80)"><em>80%</em></span> <span
												class="progress-button" data-progress-value="90"
												onclick="updateProgress(90)"><em>90%</em></span> <span
												class="progress-button" data-progress-value="100"
												onclick="updateProgress(100)"><em>100%</em></span>
										</div>
										<span class="js-progress-text progress-txt">0%</span>
									</div> <script>
						   function updateProgress(percent) {
					            const progressBar = document.querySelector('.progress-graph-bar');
					            const progressButtons = document.querySelectorAll('.progress-button');
					            const progressText = document.querySelector('.js-progress-text');

					            progressBar.style.width = (percent*1.3) +'px';
					            progressText.textContent = percent + '%';

					            progressButtons.forEach(button => {
					                const em = button.querySelector('em');

					                if (parseInt(button.dataset.progressValue, 10) === percent) {
					                    em.style.display = 'block';
					                } else {
					                    em.style.display = 'none';
					                }
					            });
					        }
    					</script>
								</li>
							</ul>
							<button type="button" class="js-more-button add-button"
								style="display: block" data="">
								<i class="fa-solid fa-plus"
									style="color: #555; margin-right: 10px;"></i>항목추가입력
							</button>
						</div>
						<div id="postCntn" class="js-content-area create-content-area" style="display:block;">
							<div class="js-upload-area js-paste-layer create-post-content"
								contenteditable="true" placeholder="내용을 입력하세요."
								spellcheck="false" ondrop="drop(event)"
								ondragover="allowDrop(event)">
								<div id="mini-map" contentEditable='false'></div>
							</div>
						</div>
						<div class="subtask-space">
							<div class="js-subtask-area subtask-wrap" style="display:none;">
								<div class="subtask-header">
									<span class="subtask-title"> <img
										src=Images/icons8-folder-tree-64.png
										style="width: 20px; margin-right: 10px;">하위업무<em
										class="js-subtask-count subtask-count"></em>
									</span>
								</div>
								<div class="subtask-bottom js-subtask-edit-layer"
									style="display: block;">
									<div class="subtask-registered-area js-subtask-edit-area">
										<div class="subtask-input-area js-subtask-li"
											style="display: none;">
											<div
												class="js-subtask-status-layer js-subtask-layer subtask-status-area">
												<button type="button"
													class="js-subtask-status-button subtask-button subtask-status request"
													data_status="0">요청</button>
												<ul
													class="js-status-setting-layer js-subtask-layer subtask-status-list"
													style="display: none">
													<li>
														<div
															class="js-status-setting-button subtask-status request"
															data_status_code="0">요청</div>
													</li>
													<li>
														<div
															class="js-status-setting-button subtask-status progress"
															data_status_code="1">진행</div>
													</li>
													<li>
														<div
															class="js-status-setting-button subtask-status feedback"
															data_status_code="4">피드백</div>
													</li>
													<li>
														<div
															class="js-status-setting-button subtask-status completion"
															data_status_code="2">완료</div>
													</li>
													<li>
														<div class="js-status-setting-button subtask-status hold"
															data_status_code="3">보류</div>
													</li>
												</ul>
											</div>
											<input type="text" class="subtask-input js-subtask-input"
												tab-code="input" maxlength="100"
												data-empty-msg="하위 업무 제목을 입력하세요." data-required-yn="Y"
												placeholder="업무명 입력 (Enter로 업무 연속 등록 가능)">
											<ul class="js-subtask-menu subtask-menu">
												<li class="js-subtask-date-layer subtask-menu-date js-mouseover js-date-tooltip">
													<span class="js-pickr-layer js-datepick-button subtask-button">
													   <input type="hidden" class="flatpickr flatpickr-input" id="hidden-datepicker1" readonly="readonly">
													     <span class="create-icon-box js-pickr-icon" id="datepickerr" onclick="showDatePicker1();">
													       <i class="fa-regular fa-calendar"></i>
													      </span>
													     <input type="text" id="selectedDate1" style="width: 90px !important; display:none;"readonly="" />
													   </span>
													</li>
													 <script>
												      function showDatePicker1() {
												        let picker = flatpickr("#hidden-datepicker1", {
												          onChange: function(selectedDates, dateStr, instance) {
												            document.getElementById("selectedDate1").value = dateStr;
												            instance.close();
												            document.getElementById("selectedDate1").style.display = "inherit";
												            document.getElementById("datepickerr").style.display = "none";
												          }
												        });
												        picker.open();
												      }
												    </script>
												<li id ="prioritysub" class="js-subtask-priority-layer js-subtask-layer subtask-menu-priority js-mouseover clearfix"
													data_priority="" mouseover-text="우선순위 추가">
													<button type="button"
														class="js-priority-button js-subtask-priority subtask-button create-icon-box small">	
														<span> <i class="fa-regular fa-flag" style="color: #000000; font-size: 20px;"></i>
														</span>
													</button>

												</li>
												<li class="subtask-menu-worker js-subtask-worker-layer js-mouseover"
													data_worker_id_list="" data_worker_name_list=""
													data_worker_profile_list="" mouseover-text="담당자 추가">
													<button type="button"
														class="js-worker-button subtask-button manager js-worker-box create-icon-box small"
														tab-code="worker">
														<span> <i class="fa-regular fa-user"></i>
														</span>
													</button>
												</li>
											</ul>
											<button type="button"
												class="js-subtask-enter-button subtask-enter">
												<i class="icons-reply"></i>
											</button>
											<button type="button" class="subtask-register-btn off">
												<span class="blind">Register</span>
											</button>
											<div class="js-priority-setting-layer priority-group sub"
												style="display: none; top: -150px; left: 450px;">
												<button type="button"
													class="js-priority-setting-button js-subtask-priority priority-button"
													data-key-index="0" data_priority_code="">
													<span> <span style=" color: #999;">x</span>
													</span>취소
												</button>
												<button type="button"
													class="js-priority-setting-button js-subtask-priority priority-button"
													data-key-index="1" data_priority_code="0">
													<span><i class="fa-solid fa-arrow-down" style="color: color: #777;"></i>	
													</span>낮음
												</button>
												<button type="button"
													class="js-priority-setting-button js-subtask-priority priority-button"
													data-key-index="2" data_priority_code="1">
													<span> <span style="width: 12px; font-weight: 800; color: #60c000;">ㅡ</span>
													</span>보통
												</button>
												<button type="button"
													class="js-priority-setting-button js-subtask-priority priority-button"
													data-key-index="3" data_priority_code="2">
													<span> <i class="fa-solid fa-arrow-up" style="color: #ff7d04;"></i>
													</span>높음
												</button>
												<button type="button"
													class="js-priority-setting-button js-subtask-priority priority-button"
													data-key-index="4" data_priority_code="3">
													<span> <i class="fa-solid fa-tower-broadcast" style="color: #ec1e1e;"></i>
													</span>긴급
												</button>
											</div>
										</div>
									</div>
								</div>
								<script>
								$(document).ready(function () {
										  $(".js-priority-setting-button.main").click(function() {
										    // 각 버튼의 텍스트 값을 가져옵니다.
										    const priorityText = $(this).text().trim();

										    // #priorityButton 요소의 텍스트를 변경합니다.
										    $("#priorityButton").text(priorityText);
										    $('.priority-group.main').css('display', 'none'); 
										  });
									  
									  let originalButton;
									  // 드롭다운 메뉴 표시
									  $('#priorityButton').on('click', function () {
									    originalButton = $(this); // 원래 버튼 참조 저장
									    $('.priority-group.main').css('display', 'block');
									  });

									  // 우선순위 버튼 클릭 이벤트 처리
									  $('.js-subtask-priority.priority-button').each(function () {
									    $(this).on('click', function () {
									      const keyIndex = $(this).attr('data-key-index');

									      if (keyIndex == 0) {
									        // 취소 버튼 클릭 시 원래 버튼 처음 상태로 되돌리기
									        originalButton.html('<i class="fa-regular fa-flag" style="color: #000000; font-size: 20px;"></i>');
									      } else {
									        // 다른 버튼 클릭 시 아이콘 변경
									        const iconHTML = $(this).find('span:first-child').html();
									        originalButton.html(iconHTML);
									      }
									      originalButton.click();
									      $('.priority-group.sub').css('display', 'none'); 
									    });
									  });

									  // 버튼 처음 클릭되는 경우 드롭다운 메뉴 표시 이벤트
									  $(document).on('click', '#prioritysub', function () {
									    $('.priority-group.sub').css('display', 'block');
									  });
									});
								</script>
								<button type="button" class="js-add-subtask-button add-button">
									<i class="icons-plus-7"></i>하위업무 추가
								</button>
							</div>
						</div>
						<!-- 일정 -->
					<div class="post-card-content js-schedule-comp"style="display:none;" spellcheck="true">
							<ul class="create-content-group">
								<li id="editDateTimeArea"
									class="schedule-date-li js-schedule-date-layer">
									<div class="create-content-cell title">
										<i class="fa-regular fa-calendar"
												style="font-size: 18px;color: #000;margin-right: 6px;"></i>
									</div>
									<div class="create-content-cell">
										<div class="schedule-time">
											<div class="js-pickr-layer js-start-flatpickr">
													<input class="js-pickr-text schedule-input"type="text" readonly="">
											</div>
											<div class="js-pickr-layer js-end-flatpickr">
												<input class="js-pickr-text schedule-input" type="text" readonly="">
											</div>
											<div class="oneday">
												<input type="checkbox" id="ondDay"> <label>종일</label>
											</div>
										</div>
									</div>
								</li>
								<li class="js-attendance-layer">
									    <div class="create-content-cell title manager">
									        <i class="icon-post-worker"></i>
									    </div>
									    <div class="create-content-cell manager-btn-group">
									        <div class="user-wrap">
									            <span class="js-manager-group manager-group"> 
									            </span> <input type="text"
									                class="js-worker-input worker-search-input attendance"
									                placeholder="참석자 추가" style="display: inline-block;">
									        </div>
									        <button type="button"
									            class="js-worker-button add-manager-button"
									            style="display: none;">참석자 추가</button>
									    </div>
									</li>
									<script>
									 const attendanceInput = document.querySelector(".js-worker-input.worker-search-input.attendance");
									    const attendanceWorkerGroup = document.querySelector(".js-manager-group");

									    attendanceInput.addEventListener("keydown", (event) => {
									      if (event.key === "Enter" || event.keyCode === 13) {
									        event.preventDefault();

									        const name = event.target.value;
									        document.querySelector(".js-worker-input.worker-search-input.attendance").style.display="none";
									        const workerItem = document.createElement("div");
									        workerItem.classList.add("js-registration", "manager-item");
									        attendanceWorkerGroup.appendChild(workerItem);

									        const nameText = document.createTextNode(name);
									        workerItem.appendChild(nameText);

									        const removeButton = document.createElement("button");
									        removeButton.type = "button";
									        removeButton.classList.add("js-remove-worker", "remove-button");
									        removeButton.addEventListener("click", () => {
									          attendanceWorkerGroup.removeChild(workerItem);
									          document.querySelector(".js-worker-input.worker-search-input.attendance").style.display = "inline-block";
									        });
									        workerItem.appendChild(removeButton);
									        event.target.value = "";
									      }
									    });
									</script>
								<li class="schedule-place">
									<div class="create-content-cell title manager">
										<i class="fa-solid fa-location-dot"></i>
									</div>
									<div class="create-content-cell">
										<input id="search-box1" class="upload-menu map-search1"
											style="display: block; position:initial;" type="text" placeholder="장소 검색하세연">
									</div>
								</li>
						<script>
						  initAutocomplete1();
						</script> 

								<li>
									<div class="create-content-cell title">
										<i class="icon-post-alarm"></i>
									</div>
									<div class="create-content-cell">
										<span id="alarmSpan" class="alarm-text d-none">없음</span> 
										<select id="alarmButton" class="alarm-select"><option
												value="0">없음</option>
											<option value="10">10분 전 미리 알림</option>
											<option value="30">30분 전 미리 알림</option>
											<option value="60">1 시간 전 미리 알림</option>
											<option value="120">2 시간 전 미리 알림</option>
											<option value="180">3 시간 전 미리 알림</option>
											<option value="1440">1일 전 미리 알림</option>
											<option value="2880">2일 전 미리 알림</option>
											<option value="10080">7일 전 미리 알림</option></select>
									</div>
								</li>
										<div id="postCntn1" class="js-content-area create-content-area" >
									<i class="icon-post-memo"></i>
											<div class="js-upload-area js-paste-layer create-post-content"
											contenteditable="true" placeholder="내용을 입력하세요."
											spellcheck="false" ondrop="drop(event)"
											ondragover="allowDrop(event)" style="padding: 0;">
											<div id="mini-map1" contentEditable='false'></div>
										</div>
									</div>
							<script>
								  document.addEventListener("DOMContentLoaded", function () {
								    var input1 = document.getElementById("search-box1");
								    var miniMapDiv = document.getElementById("mini-map1");
								
								    var searchBox = new google.maps.places.SearchBox(input1);
								
								    searchBox.addListener("places_changed", function () {
								      var places = searchBox.getPlaces();
								
								      if (places.length === 0) {
								        return;
								      }
								
								      var place = places[0];
								      var lat = place.geometry.location.lat();
								      var lon = place.geometry.location.lng();
								      var placeName = place.name;
								      var placeAddress = place.formatted_address;
								
								      var mapImageUrl =
								        "https://maps.googleapis.com/maps/api/staticmap?center=" +
								        lat +
								        "," +
								        lon +
								        "&zoom=14&size=580x240&maptype=roadmap&markers=color:blue%7C" +
								        lat +
								        "," +
								        lon +"&key=AIzaSyAGqbkrXZ42f8TtH3Sv6Uu4edzDm3EvCoM";
								
								      var infoDiv =
								        "<div style='width:585px; height:340px; border: 1px solid black; display: inline-block;'>";
								      infoDiv += "<img src='" + mapImageUrl + "' alt='지도 이미지'>";
								      infoDiv += "<h4 style='margin:0;'>" + placeName + "</h4>";
								      infoDiv += "<p style='margin:0;'>" + placeAddress + "</p>";
								      infoDiv += "</div>";
								
								      miniMapDiv.innerHTML = infoDiv;
								
								      input1.style.display = "none";
								    });
								  });
							</script>
							</ul>
						</div>
						<div class="postCntn3" style="display:none;">
						<ul id="todoEditUl" class="todo-group"></ul>
						<div class="subtask-input-area todo-area">
				            <input id="todoContent" type="text" class="js-todo-content-input" placeholder="할 일 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off" maxlength="60" data-empty-msg="할 일을 입력하세요" data-required-yn="Y" data-over-msg="60자를 초과할 수 없습니다.">
				            <div class="todo-menu">
				                <span class="js-pickr-layer subtask-button">
								   <input type="hidden" class="flatpickr flatpickr-input" id="hidden-datepicker" readonly="readonly">
								     <span class="create-icon-box js-pickr-icon" id="datepicker" onclick="showDatePicker();">
								       <i class="fa-regular fa-calendar"></i>
								      </span>
								     <input type="text" id="selectedDate" style="width: 90px !important; display:none;"readonly="" />
								   </span>
				                <button id="todoWorkerButton" type="button" class="js-worker-button subtask-button">
				                    <span class="create-icon-box"><i class="icon-post-worker"></i></span>
				                </button>
				            </div>
				        </div>
				        </div>
				         <script>
					      function showDatePicker() {
					        let picker = flatpickr("#hidden-datepicker", {
					          onChange: function(selectedDates, dateStr, instance) {
					            document.getElementById("selectedDate").value = dateStr;
					            instance.close();
					            document.getElementById("selectedDate").style.display = "inherit";
					            document.getElementById("datepicker").style.display = "none";
					          }
					        });
					        picker.open();
					      }
					    </script>	
				        <script>
				        document.addEventListener("DOMContentLoaded", function () {
				        	  var todoContentInput = document.getElementById("todoContent");
				        	  var todoContentInput1 = document.getElementById("selectedDate");
				        	  var todoEditUl = document.getElementById("todoEditUl");
				        	  var datepickerInput = document.getElementById("hidden-datepicker");

				        	  todoContentInput.addEventListener("keydown", function (event) {
				        	    if (event.key === "Enter") {
				        	      event.preventDefault();

				        	      var todoValue = todoContentInput.value.trim();
				        	      var todoValue1 = todoContentInput1.value.trim();
				        	      if (todoValue !== "") {
				        	        var newTodoDiv = document.createElement("div");
				        	        newTodoDiv.className = "subtask-input-area todo-area clone";
				        	        newTodoDiv.innerHTML = `
				        	          <input id="todoContent" type="text" class="js-todo-content-input" placeholder="할 일 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off" maxlength="60" data-empty-msg="할 일을 입력하세요" data-required-yn="Y" data-over-msg="60자를 초과할 수 없습니다." style="border:none;">
				        	          <div class="todo-menu">
				        	            <span class="js-pickr-layer subtask-button">
				        	              <input type="text" class="selectedDate" onclick="showDatePicker();" style="width: 90px !important; display:inherit;"readonly="" />
				        	            </span>
				        	            <button id="todoWorkerButton" type="button" class="js-worker-button subtask-button">
				        	              <span class="create-icon-box"><i class="icon-post-worker"></i></span>
				        	            </button>
				        	            <button type="button" class="js-todo-remove-btn"></button>
				        	          </div>
				        	        `;

				        	        var todoContentInputNew = newTodoDiv.querySelector(".js-todo-content-input");
				        	        todoContentInputNew.setAttribute("value", todoValue);
				        	        todoContentInputNew.style.border = "none";

				        	        var todoContentInputNew = newTodoDiv.querySelector(".selectedDate");
				        	        todoContentInputNew.setAttribute("value", todoValue1);
				        	        
				        	        todoEditUl.appendChild(newTodoDiv);
				        	        todoContentInput.value = "";
				        	        todoContentInput1.value = "";
				        	        document.querySelector("#datepicker").style.display = "inline-block";
				        	        document.querySelector("#selectedDate").style.display = "none";
				        	        
				        	      }
				        	    }
				        	  });
				        	});
				        // 삭제 버튼에 대한 이벤트 리스너를 추가하는 코드
				        document.addEventListener("DOMContentLoaded", function () {
				            var todoEditUl = document.getElementById("todoEditUl");
				            
				            // 삭제 버튼 클릭 시, 해당 clone 제거
				            todoEditUl.addEventListener("click", function (event) {
				                if (event.target && event.target.classList.contains("js-todo-remove-btn")) {
				                    event.target.closest(".js-todo-edit-layer").remove();
				                }
				            });
				        });
				        </script>
<!-- 				        투표 -->
				        <div class="postCntn4 create-content-area" style="display:none;">
				        	<div class="vote-post-content" contenteditable="true" placeholder="투표에 관한 설명 입력 (옵션)" spellcheck="false"></div>
				        	<div class="vote-area">
				        		<div class="vote-list">
									 <div class="vote-option-input-area">
					                    <div class="vote-input-area">
					                        <p>
					                            <input type="text" class="vote-option-input-text" placeholder="항목 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off" maxlength="60">
					                        </p>
					                        <div class="vote-img-box">
					                            <span class="add-img-box "><i class="icons-picture"></i></span>
					                            <button class="del-img-button" style="display: none;"><i class="icons-close-3"></i></button>
					                        </div>
					                    </div>
					                    <div class="vote-input-area">
					                        <p>
					                            <input type="text" class="vote-option-input-text" placeholder="항목 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off" maxlength="60">
					                        </p>
					                        <div class="vote-img-box">
					                            <span class="add-img-box "><i class="icons-picture"></i></span>
					                            <button class="del-img-button" style="display: none;"><i class="icons-close-3"></i></button>
					                        </div>
					                    </div>
					                </div>
					                <button type="button" id="vote-add" class="vote-option-add-button">+ 투표 항목 추가</button>	
				        		</div>
				        	</div>
				        	<div class="vote-option-container">
				        		<ul class ="vote-option-wrap">
					        		<li class="vote-deadline">
					        			<div class="vote-option-text">
					        				<i class="fa-solid fa-clock-rotate-left"></i>
					        				<span>투표 마감일</span>
					        			</div>
					        			<div class="vote-date-wrap">
					        				<input id="datepicker8" value="마감일 추가" type="text">
					        			</div>
					        		</li>
					        		<li class="vote-multiple">
						        		<div class="vote-option-text">
						        			<i class="fa-solid fa-check-double"></i>
						        			<span>복수 투표</span>
						        		</div>
						        		<button type="button" class="vote-option toggle-button">
					                        <i class="handle"></i>
					                    </button>
					        		</li>
					        		<li class="vote-anonymous">
						        		<div class="vote-option-text">
						        			<i class="fa-solid fa-question"></i>
						        			<span>익명 투표</span>
						        		</div>
						        		<button type="button" class="vote-option toggle-button">
					                        <i class="handle"></i>
					                    </button>
					        		</li>
					        		<li class="vote-anyone">
						        		<div class="vote-option-text">
						        			<i class="fa-solid fa-user-plus"></i>
						        			<span>투표 중 누구나 항목 추가 가능</span>
						        		</div>
						        		<button type="button" class="vote-option toggle-button">
					                        <i class="handle"></i>
					                    </button>
					        		</li>
					        		<li class="vote-private">
						        		<div class="vote-option-text">
						        			<i class="fa-solid fa-lock"></i>
						        			<span>투표 결과 나만 보기</span>
						        		</div>
						        		<button type="button" class="vote-option toggle-button">
					                        <i class="handle"></i>
					                    </button>
					        		</li>
					        		<li class="vote-opentype">
						        		<div class="vote-option-text">
						        			<i class="fa-solid fa-volume-high"></i>
						        			<span>투표 결과 공개 시점</span>
						        		</div>
						        		<div class="vote-check">
										  <input type="radio" name="vote" onchange="handleChange(this)" value="real-time" /> 실시간
										  <input type="radio" name="vote" onchange="handleChange(this)" value="after-vote" /> 투표 종료 후
										</div>
					        		</li>
				        		</ul>
				        	</div>
				        </div>
				        <script>
				        document.addEventListener("DOMContentLoaded", function() {
				            var plusButton = document.getElementById("vote-add");
				            var inputText = document.querySelector(".vote-option-input-text");
				            var voteArea = document.querySelector(".vote-option-input-area");
				          
				            function loadImageHandler() {
				                const fileInput = document.createElement("input");
				                fileInput.type = "file";
				          
				                fileInput.addEventListener("change", event => {
				                    const selectedFile = event.target.files[0];
				                    if (selectedFile.type.startsWith("image/")) {
				                        const imageUrl = URL.createObjectURL(selectedFile);
				                        const image = document.createElement("img");
				                        image.src = imageUrl;
				                        image.style.width = "34px";
				                        image.style.height = "34px";
				                        image.style.borderRadius = "14px";
				                        this.innerHTML = "";
				                        this.appendChild(image);
				                    }
				                });
				          
				                fileInput.click();
				            }
				          
				            function init() {
				                const voteImgBoxes = document.querySelectorAll(".vote-img-box");
				          
				                if (voteImgBoxes) {
				                    voteImgBoxes.forEach(voteImgBox => {
				                        voteImgBox.addEventListener("click", loadImageHandler);
				                    });
				                }
				            }
				          
				            plusButton.addEventListener("click", function(event) {
				                event.preventDefault();
				                const inputValue = inputText.value.trim();
				                if (inputValue !== "") {
				                    var newVoteDiv = document.createElement("div");
				                    newVoteDiv.className = "vote-input-area";
				                    newVoteDiv.innerHTML = `
				                      <p>
				                        <input type="text" class="vote-option-input-text" placeholder="항목 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off" maxlength="60">
				                      </p>
				                      <div class="vote-img-box">
				                        <span class="add-img-box "><i class="icons-picture"></i></span>
				                        <button class="del-img-button" style="display: none;"><i class="icons-close-3"></i></button>
				                      </div>
				                  `;
				                    voteArea.appendChild(newVoteDiv);
				                    const newVoteImgBox = newVoteDiv.querySelector(".vote-img-box");
				          
				                    if (newVoteImgBox) {
				                        newVoteImgBox.addEventListener("click", loadImageHandler);
				                    }
				                }
				            });
				          
				            init();
				        });
				        const voteCheck = document.querySelector('.vote-check');

				        function handleChange(input) {
				          const value = input.value;

				          // value 값에 따라 클래스 추가/제거합니다.
				          if (value === 'real-time') {
				            voteCheck.classList.add('real-time');
				            voteCheck.classList.remove('after-vote');
				          } else {
				            voteCheck.classList.add('after-vote');
				            voteCheck.classList.remove('real-time');
				          }
				        }
				        </script>
				        </div>
					</fieldset>
				</div>
			</div>
			<div class="create-post-footer clearfix1">
				<ul class="js-bottom-ul create-button-group clearfix">
					<li class="js-bottom-item" data-code="upload-file"
						style="display: inline-block;">
						<button mouseover-text="파일 첨부" class="js-file-button js-mouseover">
							<i class="fa-solid fa-paperclip"></i> <input type="file"
								id="fileInput" style="display: none" />
						</button> 
						<script>
                        function init() {
                            const fileButton = document.querySelector('.js-file-button.js-mouseover');
                            const fileInput = document.getElementById('fileInput');
                            const uploadArea = document.querySelector('.js-upload-area.js-paste-layer.create-post-content');

                            if (fileButton) {
                                fileButton.addEventListener('click', () => {
                                    if (fileInput) {
                                        fileInput.click();
                                    } 
                                });
                            } 

                            if (fileInput) {
                                fileInput.addEventListener('change', (event) => {
                                    if (uploadArea) {
                                        const selectedFile = event.target.files[0];
                                        if (selectedFile.type.startsWith('image/')) {
                                            const image = document.createElement('img');
                                            image.src = URL.createObjectURL(selectedFile);
                                            image.style.maxWidth = '550px';
                                            uploadArea.appendChild(image);
                                        } else {
                                            uploadArea.innerHTML = `선택된 파일: ${selectedFile.name}`;
                                        }
                                    } 
                                });
                            }
                        }

                        document.addEventListener('DOMContentLoaded', init);
    					</script>
					</li>
					<li class="js-bottom-item" data-code="google-place"
						style="display: inline-block;">
						<button mouseover-text="장소 첨부" class="js-map-button js-mouseover">
							<i class="fa-solid fa-location-dot"></i>
						</button> <input id="search-box" class="upload-menu map-search"
						style="display: none;" type="text" placeholder="장소 검색하세연">
						<script>
						  initAutocomplete();
						</script> 
						<script>
						var input12 = document.getElementById("search-box");

						// 검색 박스를 감싼 SearchBox 객체를 만듭니다.
						var searchBox = new google.maps.places.SearchBox(input12);

						// SearchBox 객체에서 장소 검색이 완료되면 이벤트 핸들러가 실행됩니다.
						searchBox.addListener("places_changed", function () {
						  // 검색 결과를 저장합니다.
						  var places = searchBox.getPlaces();

						  // 검색 결과가 없으면 함수를 종료합니다.
						  if (places.length === 0) {
						    return;
						  }

						  // 검색 결과에서 첫 번째 장소만 가져옵니다.
						  var place = places[0];

						  // 장소에 대한 위치 정보를 가져옵니다.
						  var lat = place.geometry.location.lat();
						  var lon = place.geometry.location.lng();
						  
						  // 장소 이름과 주소 정보를 가져옵니다.
						  var placeName = place.name;
						  var placeAddress = place.formatted_address;

						  // 미니맵이 들어갈 div 요소를 가져옵니다.
						  var miniMapDiv = document.getElementById("mini-map");

						  // Google Maps API로 부터 지도 이미지를 가져와서 미니맵 요소에 넣습니다.
						  var mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="+lat+","+lon+"&zoom=14&size=580x250&maptype=roadmap&markers=color:blue%7C"+lat+","+lon+"&key=AIzaSyAGqbkrXZ42f8TtH3Sv6Uu4edzDm3EvCoM";
						// 지도 이미지, 장소 이름, 주소 정보를 하나의 div에 묶고 테두리로 감쌉니다.
						  var infoDiv = "<div style='width:585px; height:340px; border: 1px solid black; display: inline-block;'>";
						  infoDiv += "<img src='" + mapImageUrl + "' alt='지도 이미지'>";
						  infoDiv += "<h4 style='margin:0;'>" + placeName + "</h4>";
						  infoDiv += "<p style='margin:0;'>" + placeAddress + "</p>";
						  infoDiv += "</div>";

						  // 생성한 div를 미니 맵 요소에 추가합니다.
						  miniMapDiv.innerHTML = infoDiv;
						});
					</script>
					</li>
					<li class="js-bottom-item hashtag-item" data-code="hash-tag"
						style="display: inline-block;">
						<button>
							<i class="fa-solid fa-hashtag"></i>
						</button>
						<div class="tooltip">해시태그 - ‘#’ 입력후 내용을 쓰고 스페이스 바로 설정</div>
					</li>
					<li class="js-bottom-item mention-item" data-code="mention-tag"
						style="display: inline-block;">
						<button>
							<span style="font-size: 18px;">@</span>
						</button>
						<div class="tooltip">멘션 - ‘@’ 입력후 이름을 쓰고 ↑,↓,Enter로 설정</div>
					</li>
					<li class="js-bottom-item text-item" data-code="style-tag"
						style="display: inline-block;">
						<button>
							<i class="fa-solid fa-t"></i>
						</button>
						<div class="tooltip">굵게/기울임/밑줄/취소선 - 글내용을 드래그하여 설정</div>
					</li>
				</ul>

				<div class="create-footer-menu" style="display: flex;">
					<div class="private-button create-submit-option full"
						style="display: inline-block" data="">전체 공개</div>
					<ul class="create-post-option" style="display: none">
						<li>
							<div class="js-private-option option-item full"
								data-private="full">
								<i class="icons-person-7"></i>전체 공개
							</div>
						</li>
						<li>
							<div class="js-private-option option-item admin"
								data-private="admin">
								<i class="icons-lock"></i>프로젝트 관리자만
							</div>
						</li>
					</ul>
					<a
						class="js-temporary-btn create-button temporary-post-submit list"
						style="display: block;"> <span>임시저장</span> <span
						class="js-temporary-count sum">0</span>
					</a>
					<button class="create-post-submit"
						style="display: inline-block;">등록</button>
					<div class="js-editing-buttons d-none" style="display: none;">
						<button type="button" class="cancel-button create-post-button">취소</button>
						<button type="button"
							class="js-complete-btn edit-button create-post-button confirm">
							등록</button>
					</div>
					<div class="js-end-buttons d-none" style="display: none;">
						<button type="button" class="cancel-button create-post-button">취소</button>
						<button type="button"
							class="js-end-btn create-post-button confirm">저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
	function initTaskOption() {
		  var taskOptions = document.querySelector(".js-task-option");
		  if (taskOptions) {
		    taskOptions.style.display = "none";
		  }

		  var subtaskWrap = document.querySelector(".subtask-wrap");
		  if (subtaskWrap) {
		    subtaskWrap.style.display = "none";
		  }
		}
	
	function removeId(element) {
	    if (element.removeAttribute) {
	        element.removeAttribute("id");
	    }
	    Array.from(element.children).forEach(removeId);
	}

	function showElementBySelector(selector) {
	    var elements = document.querySelectorAll(selector);
	    elements.forEach(function (element) {
	        element.style.display = "block";
	    });
	}

	function hideElementBySelector(selector) {
	    var elements = document.querySelectorAll(selector);
	    elements.forEach(function (element) {
	        element.style.display = "none";
	    });
	}

	function activateTab(tab) {
	    var tabs = document.querySelectorAll(".create-tab");
	    tabs.forEach(function (otherTab) {
	        otherTab.classList.remove("active");
	    });
	    tab.classList.add("active");
	}

	var tabWrite2 = document.querySelector(".tab-write2");
	var tabTask = document.querySelector(".tab-task");
	var tabSchedule = document.querySelector(".tab-schedule");
	var tabTodo = document.querySelector(".tab-todo");
	var tabVote = document.querySelector(".tab-vote");
	
	function selectTabByIndex(index) {
	    // 탭 인덱스에 따라 활성화할 탭을 결정합니다.
	    var tabs = [tabWrite2, tabTask, tabSchedule, tabTodo, tabVote];
	    var selectedTab = tabs[index];
	    activateTab(selectedTab);
	}

	tabWrite2.addEventListener("click", function () {
	    showElementBySelector("#postCntn");
	    hideElementBySelector(".js-task-option, .subtask-wrap, .js-schedule-comp, .postCntn3, .postCntn4");
	    activateTab(this);
	});

	tabTask.addEventListener("click", function () {
	    hideElementBySelector(".js-schedule-comp, .postCntn3, .postCntn4");
	    showElementBySelector("#postCntn,.js-task-option, .subtask-wrap");
	    activateTab(this);
	});

	tabSchedule.addEventListener("click", function () {
	    hideElementBySelector("#postCntn, .js-task-option, .subtask-wrap, .postCntn3, .postCntn4");
	    showElementBySelector(".js-schedule-comp");
	    activateTab(this);
	});

	tabTodo.addEventListener("click", function () {
	    hideElementBySelector("#postCntn, .js-task-option, .subtask-wrap, .js-schedule-comp, .postCntn4");
	    showElementBySelector(".postCntn3");
	    activateTab(this);
	});

	tabVote.addEventListener("click", function () {
	    hideElementBySelector("#postCntn, .js-task-option, .subtask-wrap, .js-schedule-comp, .postCntn3");
	    showElementBySelector(".postCntn4");
	    activateTab(this);
	});

	function formatDateTime() {
	    var now = new Date();
	    var year = now.getFullYear();
	    var month = (now.getMonth() + 1).toString().padStart(2, '0');
	    var day = now.getDate().toString().padStart(2, '0');
	    var hours = now.getHours().toString().padStart(2, '0');
	    var minutes = now.getMinutes().toString().padStart(2, '0');
	    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
	}
	
	// tabWrite2 클릭 이벤트 핸들러
	tabWrite2.addEventListener("click", function () {
	  showElementBySelector("#postCntn");
	  hideElementBySelector(".js-task-option, .subtask-wrap, .js-schedule-comp, .postCntn3, .postCntn4");
	  activateTab(this);
	});

	// tabTask 클릭 이벤트 핸들러
	tabTask.addEventListener("click", function () {
	  hideElementBySelector(".js-schedule-comp, .postCntn3, .postCntn4");
	  showElementBySelector("#postCntn,.js-task-option, .subtask-wrap");
	  activateTab(this);
	});

	// tabSchedule 클릭 이벤트 핸들러
	tabSchedule.addEventListener("click", function () {
	  hideElementBySelector("#postCntn, .js-task-option, .subtask-wrap, .postCntn3, .postCntn4");
	  showElementBySelector(".js-schedule-comp");
	  activateTab(this);
	});

	// tabTodo 클릭 이벤트 핸들러
	tabTodo.addEventListener("click", function () {
	  hideElementBySelector("#postCntn, .js-task-option, .subtask-wrap, .js-schedule-comp, .postCntn4");
	  showElementBySelector(".postCntn3");
	  activateTab(this);
	});

	// tabVote 클릭 이벤트 핸들러
	tabVote.addEventListener("click", function () {
	  hideElementBySelector("#postCntn, .js-task-option, .subtask-wrap, .js-schedule-comp, .postCntn3");
	  showElementBySelector(".postCntn4");
	  activateTab(this);
	});
	
	
	document.querySelector(".create-post-submit").addEventListener("click", function () {
	    var postTitle = document.querySelector("#postTitle").value;

	    var activeContent;

	    if (tabWrite2.classList.contains("active")) {
	        activeContent = document.querySelector("#postCntn");
	        activeContent.classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-task-option").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".subtask-wrap").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-schedule-comp").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn3").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn4").classList.add("blockk"); // 요소에 block 클래스 추가
	    } else if (tabTask.classList.contains("active")) {
	        activeContent = document.querySelector("#postCntn");
	        var taskOptions = document.querySelector(".js-task-option");
	        var subtaskWrap = document.querySelector(".subtask-wrap");
	        var clonedTaskOptions = taskOptions.cloneNode(true); // 요소 복제
	        var clonedSubtaskWrap = subtaskWrap.cloneNode(true); // 요소 복제
	        clonedTaskOptions.classList.add("blockk"); // 복제된 요소에 block 클래스 추가
	        clonedSubtaskWrap.classList.add("blockk"); // 복제된 요소에 block 클래스 추가
	        activeContent.appendChild(clonedTaskOptions); // 복제된 요소 추가
	        activeContent.appendChild(clonedSubtaskWrap); // 복제된 요소 추가
	        document.querySelector(".js-schedule-comp").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn3").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn4").classList.add("blockk"); // 요소에 block 클래스 추가
	    } else if (tabSchedule.classList.contains("active")) {
	        activeContent = document.querySelector(".js-schedule-comp");
	        activeContent.classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector("#postCntn").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-task-option").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".subtask-wrap").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn3").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn4").classList.add("blockk"); // 요소에 block 클래스 추가
	    } else if (tabTodo.classList.contains("active")) {
	        activeContent = document.querySelector(".postCntn3");
	        activeContent.classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector("#postCntn").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-task-option").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".subtask-wrap").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-schedule-comp").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn4").classList.add("blockk"); // 요소에 block 클래스 추가
	    } else if (tabVote.classList.contains("active")) {
	        activeContent = document.querySelector(".postCntn4");
	        activeContent.classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector("#postCntn").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-task-option").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".subtask-wrap").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".js-schedule-comp").classList.add("blockk"); // 요소에 block 클래스 추가
	        document.querySelector(".postCntn3").classList.add("blockk"); // 요소에 block 클래스 추가
	    }

	    var originalPostCardHeader = document.querySelector(".post-card-header");
	    var newPostCardHeader = originalPostCardHeader.cloneNode(true);

	    newPostCardHeader.querySelector(".post-title").innerHTML = postTitle;

	    var dateElement = newPostCardHeader.querySelector("span.date");
	    dateElement.textContent = formatDateTime();

	    var newOriginalPost = newPostCardHeader.querySelector("#originalPost");

	    var cloneContent = activeContent.cloneNode(true);
	    cloneContent.style.display = ''; // 요소의 display 속성을 초기화

	    cloneContent.removeAttribute("id");
	    removeId(cloneContent);

	    Array.from(cloneContent.querySelectorAll(['input', 'textarea', 'button', 'select', 'a', 'label']))
	        .forEach(el => el.setAttribute('disabled', 'disabled'));
	    Array.from(cloneContent.querySelectorAll('*'))
	        .forEach(el => {
	            el.removeAttribute('id');
	            el.className = el.className.split(' ').map(cls => cls.trim()).filter(cls => !!cls).join(' ');
	            el.onclick = null;
	            el.onchange = null;
	            el.onsubmit = null;
	            el.onscroll = null;
	        });

	    newOriginalPost.innerHTML = '';
	    newOriginalPost.appendChild(cloneContent);

	    var projectFeedArea = document.querySelector("#projectFeedArea");
	    projectFeedArea.prepend(newPostCardHeader);

	    var elementToHide = document.querySelector(".flow-all-background-1.js-popup-before.d-block");
	    if (elementToHide) {
	        elementToHide.classList.remove("d-block");
	        elementToHide.classList.add("d-none");
	    }

	    var postInputElement = document.querySelector(".all-option").querySelector(".js-upload-area.js-paste-layer.create-post-content");
	    postInputElement.innerHTML = '';


	    var appendedElements = projectFeedArea.querySelectorAll(".post-card-header");
	    appendedElements.forEach(function (element) {
	        element.classList.add("immutable");
	    });
	});

	// Listen for click events on the body element
	document.body.addEventListener("click", function (event) {
	  // Check if the clicked target is the createPostArea element or contains that element
	  if (event.target.closest("#createPostArea")) {
	    // Execute the function if createPostArea is clicked
	    removeBlockkClasses();
	  }
	});

	// Move the removal logic to a separate function
	function removeBlockkClasses() {
	  var elementsWithBlockk = [
	    "#postCntn",
	    ".js-schedule-comp",
	    ".postCntn3",
	    ".postCntn4",
	    ".js-task-option",
	    ".subtask-wrap",
	  ];

	  elementsWithBlockk.forEach(function (selector) {
	    var elements = document.querySelectorAll(selector);
	    elements.forEach(function (element) {
	      if (element.classList.contains("blockk")) {
	        element.classList.remove("blockk"); // Remove blockk class
	      }
	    });
	  });

	  var activeContent = document.querySelector("#postCntn");
	  var clonedTaskOptions = activeContent.querySelector(".js-task-option");
	  var clonedSubtaskWrap = activeContent.querySelector(".subtask-wrap");
	  if (clonedTaskOptions) activeContent.removeChild(clonedTaskOptions);
	  if (clonedSubtaskWrap) activeContent.removeChild(clonedSubtaskWrap);
	}
	</script>
</body>
</html>