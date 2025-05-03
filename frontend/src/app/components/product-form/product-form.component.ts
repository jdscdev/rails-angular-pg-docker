import { Component, OnInit } from '@angular/core';
import { ReactiveFormsModule, FormGroup, FormBuilder } from '@angular/forms';
import { ProductService } from '../../services/product.service';

@Component({
  selector: 'app-product-form',
  standalone: true,
  imports: [ReactiveFormsModule],
  templateUrl: './product-form.component.html'
})
export class ProductFormComponent implements OnInit {
  form!: FormGroup;

  constructor(private fb: FormBuilder, private productService: ProductService) {}

  ngOnInit() {
    this.form = this.fb.group({
      name: [''],
      price: [0]
    });
  }

  submit() {
    if (this.form.valid) {
      const product = this.form.value;
      this.productService.createProduct(product).subscribe(response => {
        console.log('Product created:', response);
      });
    } else {
      console.log('Form is invalid');
    }
  }
}
