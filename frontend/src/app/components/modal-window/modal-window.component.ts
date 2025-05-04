import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Product, ProductService } from '../../services/product.service';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-modal-window',
  templateUrl: './modal-window.component.html',
  styleUrl: './modal-window.component.css',
  standalone: true,
  imports: [ReactiveFormsModule]
})
export class ModalWindowComponent {
  @Input() product!: Product;
  @Input() submitFunction!: (prod: Product, prodService: ProductService) => void;
  @Output() close = new EventEmitter<void>();

  form: FormGroup;

  constructor(private fb: FormBuilder, private productService: ProductService) {
    this.form = this.fb.group({
      id: [0],
      name: [''],
      price: [0]
    });
  }

  ngOnChanges() {
    if (this.product) {
      this.form.patchValue(this.product);
    }
  }
  
  submitModal(): void {
    if (this.form.valid) {
      this.submitFunction(this.form.value, this.productService);
      this.closeModal();
    } else {
      console.log('Form is invalid');
    }
  }

  closeModal(): void {
	  this.close.emit();
  }
}
