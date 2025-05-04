import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Product, ProductService } from '../../services/product.service';
import { ModalWindowComponent } from '../modal-window/modal-window.component';

@Component({
  selector: 'app-product-list',
  standalone: true,
  imports: [CommonModule, ModalWindowComponent],
  templateUrl: './product-list.component.html'
})
export class ProductListComponent implements OnInit {
  products: Product[] = [];
  editingProduct: Product | null = null;
  submitFunction: (editedProduct: Product, prodService: ProductService) => void = () => {};

  constructor(private productService: ProductService) {}

  ngOnInit(): void {
    this.loadProducts();
  }

  deleteProduct(id: number | null | undefined) {
    if (!id || isNaN(id)) {
      console.error('Product ID is required for deletion');
      return;
    }

    this.productService.deleteProduct(id).subscribe(() => {
      this.products = this.products.filter(product => product.id !== id);
    });
  }

  editProduct(editedProduct: Product, prodService: ProductService) {
    if (!editedProduct) {
      console.error('Edited product is required');
      return;
    }
    if (!editedProduct.id || isNaN(editedProduct.id)) {
      console.error('Product ID is required for editing');
      return;
    }
    if (!editedProduct.price || isNaN(editedProduct.price)) {
      console.error('Product price is required for editing');
      return;
    }
    if (!prodService) {
      console.error('Product service is required for editing');
      return;
    }

    prodService.updateProduct(editedProduct).subscribe(response => {
      console.log('Product updated:', response);
      // this.loadProducts();
    });
  }
  
  loadProducts() {
    this.productService.getProducts().subscribe(data => {
      this.products = data;
    });
  }

  showModal(product: Product) {
    this.editingProduct = product;
    this.submitFunction = this.editProduct;
  }

  closeModal() {
    this.editingProduct = null;
    this.submitFunction = () => {};
  }
}
