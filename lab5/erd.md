```Mermaid
---
config:
  layout: elk
  look: handDrawn
---
erDiagram
	direction TB
	USERS {
		int id PK
		varchar email UK
		varchar password_hash 
		timestamp created_at
		timestamp deleted_at 
	}

	BUYERS {
		int id PK 
		int user_id FK,UK
		varchar first_name
		varchar last_name
		varchar phone
	}

	SELLERS {
		int id PK  
		int user_id FK,UK  
		varchar store_name UK 
		varchar tax_id UK
		varchar iban 
		boolean is_verified  
	}

	ADMINISTRATORS {
		int id PK
		int user_id FK,UK
		varchar first_name
		varchar last_name
		enum access_level
	}

	ADDRESSES {
		int id PK
		int user_id FK
		varchar country
		varchar city
		varchar street_line
		varchar zip_code
		boolean is_default
	}

	CATEGORIES {
		int id PK
		int parent_id FK
		varchar name
	}

	PRODUCTS {
		int id PK 
		int seller_id FK
		int category_id FK 
		varchar name 
		text description  
		numeric price
		int stock_quantity
		varchar sku UK
		boolean is_active 
		int version 
		timestamp deleted_at 
	}

	PRODUCT_PRICE_HISTORY {
		int id PK 
		int product_id FK 
		numeric price 
		timestamp changed_at 
	}

	ORDERS {
		int id PK
		int buyer_id FK 
		numeric total_amount 
		enum status 
		timestamp created_at  
	}

	ORDER_ITEMS {
		int id PK  
		int order_id FK 
		int product_id FK
		int quantity 
		numeric price_at_purchase 
	}

	PAYMENTS {
		int id PK ""  
		int order_id FK 
		numeric amount 
		enum status  
		timestamp created_at 
	}

	SHIPMENTS {
		int id PK ""  
		int order_id FK,UK
		int address_id FK 
		enum status 
	}

	REVIEWS {
		int id PK
		int product_id FK
		int buyer_id FK
		int rating 
		text comment
		timestamp created_at
	}

	USERS||--o|BUYERS:"is a"
	USERS||--o|SELLERS:"is a"
	USERS||--o|ADMINISTRATORS:"is a"
	USERS||--o{ADDRESSES:"has saved"
	CATEGORIES|o--o{CATEGORIES:"parent of"
	CATEGORIES||--o{PRODUCTS:"contains"
	SELLERS||--o{PRODUCTS:"sells"
	PRODUCTS||--o{PRODUCT_PRICE_HISTORY:"logs price"
	BUYERS||--o{ORDERS:"places"
	ORDERS||--|{ORDER_ITEMS:"contains"
	PRODUCTS||--o{ORDER_ITEMS:"included in"
	ORDERS||--o{PAYMENTS:"has"
	ORDERS||--||SHIPMENTS:"shipped via"
	ADDRESSES||--o{SHIPMENTS:"destination for"
	BUYERS||--o{REVIEWS:"writes"
	PRODUCTS||--o{REVIEWS:"receives"
```