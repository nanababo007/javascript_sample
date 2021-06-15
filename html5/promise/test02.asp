<html>
<head>
	<meta charset="UTF-8">
	<title>promise 테스트 - Promise 순차 호출</title>
	<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="lib.js"></script>
</head>
<body>
<h1><a href="">Promise 로, 서버 url 순차적으로 호출하기</a></h1>
<div>
	검색어 : <input type="text" id="txtSearchKeyword" value="서울" onclick="this.select();" /> 
	<input type="button" value=" 검색 " id="btnSearch" />
	<span style="margin-left:20px;">ex) 동대문구, 남대문구, 서대문구, 서울, </span>
</div>
<div id="result" style="margin-top:10px;">
	<div id="resultAddress" style="float:left;width:300px;min-height:500px;border:1px solid #dadada;"></div>
	<div id="resultMember" style="float:left;width:300px;min-height:500px;border:1px solid #dadada;"></div>
	<div id="resultMemberAccess" style="float:left;width:300px;min-height:500px;border:1px solid #dadada;"></div>
</div>
<div style="clear:both;height:30px;"></div>
<script>
$(function(){
	//검색버튼 클릭시 이벤트 처리.
	$('#btnSearch').click(function(e){
		var sSearchKeyword = $('#txtSearchKeyword').val();
		if ($.trim(sSearchKeyword)=='')
		{
			alert('검색어를 입력해주세요.');
			$('#txtSearchKeyword').focus();
			return false;
		}
		//검색처리
		fnSearch(sSearchKeyword);
	});
	//검색입력박스 엔터 처리.
	$('#txtSearchKeyword').keydown(function(e){
		if (e.keyCode==13)
		{
			$('#btnSearch').trigger('click');
		}
	});
	//로딩시 검색입력박스 포커스 주기.
	$('#txtSearchKeyword').focus();
});
//검색함수 (순차적으로 ajax 를 호출)
function fnSearch(searchKeyword){
	//########## 주소검색 ajax 호출 시작 ##########
	//검색결과 초기화.
	$('#resultAddress').html( '' );
	$('#resultMember').html( '' );
	$('#resultMemberAccess').html( '' );
	//Promise Ajax 함수 호출.
	fnSearchPromise(1,searchKeyword)
	.then(
		function(dataBef){
			//success callback function
			var list = dataBef.list;
			var result = [];
			result.push('<center><h3>주소검색</h3></center>');
			result.push('<ul>');
			$.each(list,function(index,el){
				var sAddr = el.addr;
				var row = '';
				row += '<li>'+sAddr+'</li>';
				result.push(row);
			}); // $.each(list
			result.push('</ul>');
			$('#resultAddress').html( result.join('') );
			//검색결과 목록 글로벌 변수 저장.
			return list;
		},
		function(dataBef) {
			//fail callback function
			console.info('(error)',dataBef);
		}
	).then(
		function(dataBef){
			return fnSearchPromise(2,dataBef);
		}
	).then(
		function(dataBef){
			//success callback function
			var list = dataBef.list;
			var result = [];
			result.push('<center><h3>회원검색</h3></center>');
			result.push('<ul>');
			$.each(list,function(index,el){
				var sAddr = el.addr;
				var memberId = el.memberId;
				var row = '';
				row += '<li>'+memberId+' ('+sAddr+')</li>';
				result.push(row);
			}); // $.each(list
			result.push('</ul>');
			$('#resultMember').html( $('#resultMember').html() + result.join('') );
			return dataBef.list;
		}
	).then(
		function(dataBef){
			return fnSearchPromise(3,dataBef);
		}
	).then(
		function(dataBef){
			var result = [];
			var list = dataBef.list;
			result.push('<center><h3>회원 접속정보 검색</h3></center>');
			result.push('<ul>');
			$.each(list,function(index,el){
				var sAddr = el.addr;
				var memberId = el.memberId;
				var accessTime = el.accessTime;
				var row = '';
				row += '<li>'+memberId+' ('+accessTime+')</li>';
				result.push(row);
			});
			result.push('</ul>');
			$('#resultMemberAccess').html( $('#resultMemberAccess').html() + result.join('') );
		}
	); // fnSearchPromise
}
//Promise Ajax 호출 함수.
//### searchKind : 검색종류
//우편번호 검색 (searchKind - 1) : /test/test_js/promise/ajaxPostSearch.asp
//회원정보 검색 (searchKind - 2) : /test/test_js/promise/ajaxSearchMember.asp
//접속정보 검색 (searchKind - 3) : /test/test_js/promise/ajaxMemberAccessHistory.asp
function fnSearchPromise(searchKind,searchKeyword) {
	//url 검색 주소 (searchKind) 및 검색 종류별 파라미터 설정.
	var url = '';
	var param = {};
	if ( searchKind===1 )
	{
		url = '/test/test_js/promise/ajaxPostSearch.asp';
		param.searchParam = JSON.stringify({searchKeyword:searchKeyword});
	}
	else if ( searchKind===2 )
	{
		url = '/test/test_js/promise/ajaxSearchMember.asp';
		param.searchParam = JSON.stringify({searchKeyword:searchKeyword});
	}
	else if ( searchKind===3 )
	{
		url = '/test/test_js/promise/ajaxMemberAccessHistory.asp';
		param.searchParam = JSON.stringify({searchKeyword:searchKeyword});
	}
	else
	{
		return null;
	}
	//Promise 객체 반환.
	return new Promise(function(resolve,reject){
		fnAjaxJson(url, param, function(data){
			var list = data.list;
			if(list && list.length > 0){
				var resolveData = {};
				resolveData.list = list;
				resolveData.searchKind = searchKind;
				resolve(resolveData);
			} else {
				reject('no data');
			}
		}, function(xhr, status, error) {
			reject(xhr, status, error);
		}); // fnAjaxJson
	}); // Promise
}
</script>
</body>
</html>