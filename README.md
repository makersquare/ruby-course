README.md

- As a customer, I want to be able to make a purchase request for a puppy.

- As a breeder, I want to be able to manually input a purchase request (e.g. if a customer sent in their order via fax, letter or had a verbal agreement).

- As a breeder, I want to be able to add new puppies for sale.

- As a breeder, I want to be able to review and accept new purchase requests before they go through.

- As a breeder, I want to be able to view all completed purchase orders.

What it should be able to do:
- Customer submits purchase request. Breeder must acknowledge and accept request.
- Breeder submits purchase request.
- Breeder can review purchase orders.
- Breeder adds puppies for sale.

Classes:
Puppy
	@@varibles:
		puppies
	@variables:
		breed
		cost
		puppy_id
		sold_status

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
	
	@@variables:
		requests
	@variables:
		puppy_id
		customer_id
		request_id
		request_status

	

Module - Breeder
