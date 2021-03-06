import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [  "productsPrice", "totalPrice", "installments", "checkbox" ]

  update(e) {
    const checked = e.currentTarget.checked
    if (checked) {
      this.checkboxTargets.checked = true
    } else {
      this.checkboxTargets.checked = false
    }
    const upsellPrice = parseFloat(e.currentTarget.dataset.price)
    const currentProductsPrice = parseFloat(this.productsPriceTarget.dataset.productsPrice)
    const currentTotalPrice = parseFloat(this.totalPriceTarget.dataset.totalPrice)
    const newProductsPrice = checked ? currentProductsPrice + upsellPrice : currentProductsPrice - upsellPrice
    const newTotalPrice = checked ? currentTotalPrice + upsellPrice : currentTotalPrice - upsellPrice
    
    this.updateBankSlip(newProductsPrice, newTotalPrice)
    this.updateInstallments(newTotalPrice)

  }

  updateInstallments (totalPrice) {
    fetch(`/api/v1/installments?amount=${totalPrice * 100}`)
      .then(response => response.json())
      .then((installments) => {
        Array.from(this.installmentsTarget.children).forEach((child, index) => {
          const installmentPrice = installments["installments"][index + 1]["installment_amount"] / 100
          child.innerText = `${index + 1} X R$ ${installmentPrice.toFixed(2).replace(".", ",")}`
        })
      });
  }

  updateBankSlip (productsPrice, totalPrice) {
    this.productsPriceTarget.innerText = `R$${productsPrice.toFixed(2).replace(".", ",")}`
    this.productsPriceTarget.dataset.productsPrice = productsPrice.toFixed(2)
    this.totalPriceTarget.innerText = `R$${totalPrice.toFixed(2).replace(".", ",")}`
    this.totalPriceTarget.dataset.totalPrice = totalPrice.toFixed(2)
  }
}