package org.ofbiz.ebiz.product;

import java.util.List;

import org.ofbiz.entity.GenericValue;




public class ProductCategoryWithLevel{
		
		private GenericValue productCategory;
		private GenericValue parentProductCategory;
		private int catLevel;
		public ProductCategoryWithLevel(GenericValue productCategory,
				GenericValue parentProductCategory, int catLevel) {
			super();
			this.productCategory = productCategory;
			this.parentProductCategory = parentProductCategory;
			this.catLevel = catLevel;
		}
		public GenericValue getProductCategory() {
			return productCategory;
		}
		public void setProductCategory(GenericValue productCategory) {
			this.productCategory = productCategory;
		}
		public GenericValue getParentProductCategory() {
			return parentProductCategory;
		}
		public void setParentProductCategory(GenericValue parentProductCategory) {
			this.parentProductCategory = parentProductCategory;
		}
		public int getCatLevel() {
			return catLevel;
		}
		public void setCatLevel(int catLevel) {
			this.catLevel = catLevel;
		}
		
		/**
		 * 获取上级
		 * @param categories
		 * @return
		 */
		public ProductCategoryWithLevel getParentProductCategoryWithLevel(List<ProductCategoryWithLevel> categories){
			for (ProductCategoryWithLevel prodCatWithLevel: categories) {
				if( prodCatWithLevel.equalsProductCategory(parentProductCategory.getString("productCategoryId") )){
					return prodCatWithLevel;
				}
			}
			return null;
		}
		
		public boolean equalsProductCategory(String productCategoryId){
			if(productCategoryId.equals(productCategory.getString("productCategoryId"))){
				return true;
			}else{
				return false;
			}
		}
}