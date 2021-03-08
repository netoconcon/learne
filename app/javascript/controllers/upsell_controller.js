import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [  "productsPrice", "totalPrice", "installments" ]

  update(e) {
    const checked = e.currentTarget.checked
    const upsellPrice = parseFloat(e.currentTarget.dataset.price)
    const currentProductsPrice = parseFloat(this.productsPriceTarget.dataset.productsPrice)
    const currentTotalPrice = parseFloat(this.totalPriceTarget.dataset.totalPrice)
    const newProductsPrice = checked ? currentProductsPrice + upsellPrice : currentProductsPrice - upsellPrice
    const newTotalPrice = checked ? currentTotalPrice + upsellPrice : currentTotalPrice - upsellPrice
    
    this.updateBankSlip(newProductsPrice, newTotalPrice)
    this.updateInstallments(newTotalPrice)

  }

  updateInstallments (totalPrice) {
    Array.from(this.installmentsTarget.children).forEach((child, index) => {
      if (index === 0) {
        child.innerText = ""
      } else {
        const cf = 0.0299 / (1-(1 / Math.pow(1+0.0299, index)))
        console.log(index)
        console.log(cf)
        const installmentPrice = totalPrice * cf
        child.innerText = `${index} X R$ ${installmentPrice.toFixed(2).replace(".", ",")}`
      }
    })
  }

  updateBankSlip (productsPrice, totalPrice) {
    this.productsPriceTarget.innerText = `R$${productsPrice.toFixed(2).replace(".", ",")}`
    this.productsPriceTarget.dataset.productsPrice = productsPrice.toFixed(2)
    this.totalPriceTarget.innerText = `R$${totalPrice.toFixed(2).replace(".", ",")}`
    this.totalPriceTarget.dataset.totalPrice = totalPrice.toFixed(2)
  }
}