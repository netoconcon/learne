import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "creditCardTotal", "creditCardProductPrice", "bankSlipProductPrice", "bankSlipTotal", "installments" ]

  update(e) {
    const state = e.currentTarget.value
    const upsellPrice = parseFloat(e.currentTarget.dataset.price)
    const newProductPrice = (upsellPrice + parseFloat(this.creditCardProductPriceTarget.dataset.productPrice)).toFixed(2)
    const newTotal = (upsellPrice + parseFloat(this.creditCardTotalTarget.dataset.total)).toFixed(2)
    if (state == 'true') {
      this.creditCardTotalTarget.innerText = `Total: ${newTotal}`
      this.bankSlipTotalTarget.innerText = `Total: ${newTotal}`
      this.bankSlipProductPriceTarget.innerText = `Produtos: ${newProductPrice}`
      this.creditCardProductPriceTarget.innerText = `Produtos: ${newProductPrice}`
      this.updateInstallments(newTotal)
    } else {
      this.creditCardTotalTarget.innerText = `Total: ${this.creditCardTotalTarget.dataset.total}`
      this.bankSlipTotalTarget.innerText = `Total: ${this.bankSlipTotalTarget.dataset.total}`
      this.bankSlipProductPriceTarget.innerText = `Produtos: ${this.creditCardProductPriceTarget.dataset.productPrice}`
      this.creditCardProductPriceTarget.innerText = `Produtos: ${this.bankSlipProductPriceTarget.dataset.productPrice}`
      this.updateInstallments(this.creditCardTotalTarget.dataset.total)
    }
  }

  updateInstallments (totalValue) {
    totalValue = parseFloat(totalValue)
    Array.from(this.installmentsTarget.children).forEach((child, index) => {
      if (index === 0) {
        child.innerText = ""
      } else {
        child.innerText = `${index} X R$ ${(totalValue / parseFloat(index)).toFixed(2)}`
      }
    })
  }
}