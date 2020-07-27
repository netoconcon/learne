import { Controller } from "stimulus"
const masks = {
  cnpj (value) {
    return value
      .replace(/\D/g, '')
      .replace(/(\d{2})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d)/, '$1/$2')
      .replace(/(\d{4})(\d)/, '$1-$2')
      .replace(/(-\d{2})\d+?$/, '$1')
  },

  phone (value) {
    return value
      .replace(/\D/g, '')
      .replace(/(\d{2})(\d)/, '($1) $2')
      .replace(/(\d{4})(\d)/, '$1-$2')
      .replace(/(\d{4})-(\d)(\d{4})/, '$1$2-$3')
      .replace(/(-\d{4})\d+?$/, '$1')
  },

  cep (value) {
    return value
      .replace(/\D/g, '')
      .replace(/(\d{5})(\d)/, '$1-$2')
      .replace(/(-\d{3})\d+?$/, '$1')
  },
}

export default class extends Controller {
  static targets = [ "" ]

  connect() {

    document.querySelectorAll('input').forEach(($input) => {
      const field = $input.dataset.js
      if (typeof masks[field] !== 'undefined') {
	      $input.addEventListener('input', (e) => {
	        e.target.value = masks[field](e.target.value)
	      }, false)
	  }
    })
  }
}
