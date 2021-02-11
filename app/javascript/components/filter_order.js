const downcaseAndNoAccents = text => text.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");

const filterByName = (event) => {
  const orders = document.querySelectorAll('.product-item');
  const name_to_find = downcaseAndNoAccents(event.currentTarget.value);
  orders.forEach(ticket => {
    const customer = downcaseAndNoAccents(ticket.dataset.customerName) + downcaseAndNoAccents(ticket.dataset.customerEmail);
    // const locator = downcaseAndNoAccents(ticket.dataset.ticketLocator);
    if ((customer).search(name_to_find) === -1) {
      ticket.classList.add('d-none');
    } else {
      ticket.classList.remove('d-none');
    }
  })
};


const filterByDate = () => {

}

export { filterByName };
