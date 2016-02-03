function checkTotal() {
	document.total.value = '';
	var sum = 0;
	for (i=0;i<document.choice.length;i++) {
		if (document.choice[i].checked) {
		sum = sum + parseInt(document.choice[i].value);
		}
	}
	document.total.value = sum;
}