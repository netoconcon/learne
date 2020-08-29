import { Controller } from "stimulus"

export default class extends Controller {
	static targets = [ "table" ]

	search (e) {
		const filter = e.target.value.toUpperCase()
		const tableTrs = this.tableTarget.getElementsByTagName("tr")
		let td = []
		let txtValue = ""
		let i = 0

		for (i = 0; i < tableTrs.length; i++) {
			td = tableTrs[i].getElementsByTagName("td")[0];
			if (td) {
				txtValue = td.textContent || td.innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tableTrs[i].style.display = "";
				} else {
					tableTrs[i].style.display = "none";
				}
			}
		}
	}
}
