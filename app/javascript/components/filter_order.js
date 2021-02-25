const downcaseAndNoAccents = text => text.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");

const filterByName = (event) => {
  const orders = document.querySelectorAll('.card-product');
  console.log(orders)
  const name_to_find = downcaseAndNoAccents(event.currentTarget.value);
  console.log(name_to_find);
  orders.forEach(order => {
    const customer = downcaseAndNoAccents(order.dataset.customerName) + downcaseAndNoAccents(order.dataset.customerEmail) + downcaseAndNoAccents(order.dataset.orderId) + downcaseAndNoAccents(order.dataset.customerCpf) + downcaseAndNoAccents(order.dataset.newStatus) + downcaseAndNoAccents(order.dataset.orderStatus) + downcaseAndNoAccents(order.dataset.paymentMethod) ;
    // const locator = downcaseAndNoAccents(ticket.dataset.ticketLocator);
    if ((customer).search(name_to_find) === -1) {
      order.classList.add('d-none');
    } else {
      order.classList.remove('d-none');
    }
  })
};

export { filterByName };
