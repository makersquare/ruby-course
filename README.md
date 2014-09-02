README.md

- As a customer, I want to be able to make a purchase request for a puppy.

- As a breeder, I want to be able to manually input a purchase request (e.g. if a customer sent in their order via fax, letter or had a verbal agreement).

- As a breeder, I want to be able to add new puppies for sale.

- As a breeder, I want to be able to review and accept new purchase requests before they go through.

- As a breeder, I want to be able to view all completed purchase orders.

What it should be able to do:
** - Customer submits purchase request. 
- Breeder must acknowledge and accept request.
- Breeder submits purchase request.
- Breeder can review purchase orders.
**- Breeder adds puppies for sale.

Classes:
Puppy
	@variables:
		breed
		name
		age
		sold_status
		puppy_id

Customer
	@@variables:
		customers
	@variables:
		pending_request
		customer_id
		?name
		?phone
		?email
		?favorite breed

Purchase Request

	@variables:
		puppy_id
		customer_id
		request_id
		request_status

Breeder

Puppy Container

Purchase Request Container



Breed of the dog:

	Purchase requests are made for a specific breed, not for a specific dog.

	*Price for a puppy is set be a breed.

	*Attributes of puppy are name, breed, age.

Breed hash that stores puppies, costs.


puppy_container_hash = {
	:breed => {
		:price => ###,
		:list => [instance, instance, instance]
	}
}

purchase_request_hash = {
	:pending => {

	}
	:approved => {

	}
	:denied => {
		
	}
}