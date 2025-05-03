import { Component } from '@angular/core';
import { ProductFormComponent } from './components/product-form/product-form.component';
import { ProductListComponent } from './components/product-list/product-list.component';

@Component({
  selector: 'app-root',
  standalone: true,
  templateUrl: './app.component.html',
  imports: [
    ProductFormComponent,
    ProductListComponent
  ],
})
export class AppComponent {}
