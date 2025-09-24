import SwiftUI

struct ListProductsScreen: View {
    @StateObject private var viewModelListProduct: ListProductViewModel = ListProductViewModel()
    @State internal var productListSelected: [ProductsResponse]

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    NavigationLink {
                        ProductsScreen()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .frame(width: 20.0, height: 20.0)
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                            
                            Text("Regresar")
                                .foregroundStyle(.black)
                                .fontWeight(.bold)
                            Spacer()
                        }
                    }.padding(.leading)
                    
                    if productListSelected.isEmpty {
                        VStack {
                            Image(systemName: "doc.plaintext")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                                .frame(width: geo.size.width * 0.4, height: geo.size.height / 3)
                        }
                        .frame(width: geo.size.width, height: geo.size.height)
                    } else {
                        ScrollView {
                            LazyVGrid(
                                columns: [
                                    GridItem(.adaptive(minimum: 150.0))
                                ],
                                spacing: 10.0
                            ) {
                                ForEach(productListSelected.indices, id: \.self) { index in
                                    UCardDetailProductView(
                                        isFavorite: Binding(
                                            get: { productListSelected[index].isFavorite ?? false },
                                            set: { productListSelected[index].isFavorite = $0 }
                                        ),
                                        name: productListSelected[index].title,
                                        price: productListSelected[index].price,
                                        showDescription: false,
                                        description: productListSelected[index].description,
                                        image: productListSelected[index].image,
                                        rating: productListSelected[index].rating,
                                        actionProduct: { [weak viewModelListProduct] in
                                            viewModelListProduct?.selectedProduct = productListSelected[index]
                                        }
                                    )
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
            .navigationBarHidden(true)
            .sheet(item: $viewModelListProduct.selectedProduct) { product in
                if let index = productListSelected.firstIndex(where: { $0.id == product.id }) {
                    UCardDetailProductView(
                        isFavorite: Binding(
                            get: { productListSelected[index].isFavorite ?? false },
                            set: { productListSelected[index].isFavorite = $0 }
                        ),
                        name: productListSelected[index].title,
                        price: productListSelected[index].price,
                        showDescription: true,
                        description: productListSelected[index].description,
                        image: productListSelected[index].image,
                        rating: productListSelected[index].rating, actionFavorite:  {
                            // -MARK: Important save again newData
                            print("save again model data object")
                        })
                }
            }
        }
    }
}
