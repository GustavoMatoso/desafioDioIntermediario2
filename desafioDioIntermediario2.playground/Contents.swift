import UIKit


enum TipoCarro {
    case esportivo
    case familiar
    case utilitario
}

protocol Veiculo {
    var marca: String { get }
    var modelo: String { get }
    var ano: Int { get }
    var tipo: TipoCarro { get }

    func ligar()
    func desligar()
    func acelerar()
    func frear()
}

struct Carro: Veiculo {
    var marca: String
    var modelo: String
    var ano: Int
    var tipo: TipoCarro

    init(marca: String, modelo: String, ano: Int, tipo: TipoCarro) {
        self.marca = marca
        self.modelo = modelo
        self.ano = ano
        self.tipo = tipo
    }

    func ligar() {
        print("O carro \(marca) \(modelo) está ligado.")
    }

    func desligar() {
        print("O carro \(marca) \(modelo) está desligado.")
    }

    func acelerar() {
        print("O carro \(marca) \(modelo) está acelerando.")
    }

    func frear() {
        print("O carro \(marca) \(modelo) está freando.")
    }
}

// func para executar ações com um carro simultaneamente
func realizarAcaoConcorrente(carro: Veiculo, acao: @escaping () -> Void) {
    DispatchQueue.global().async {
        carro.ligar()
        acao()
        carro.desligar()
    }
}

var catalogoCarros: [Veiculo] = []

let carroEsportivo = Carro(marca: "Porsche", modelo: "911 GT3", ano: 2021, tipo: .esportivo)
let carroFamiliar = Carro(marca: "Volkswagen", modelo: "Jetta", ano: 2022, tipo: .familiar)
let carroUtilitario = Carro(marca: "Toyota", modelo: "SW4", ano: 2023, tipo: .utilitario)

catalogoCarros.append(carroEsportivo)
catalogoCarros.append(carroFamiliar)
catalogoCarros.append(carroUtilitario)

// execução de ações simultaneas com os carros
for carro in catalogoCarros {
    realizarAcaoConcorrente(carro: carro) {
        print("Realizando ação simultânea com o carro \(carro.marca) \(carro.modelo)")
    }
}

// sleep apenas para evitar que o playground termine antes dos prints das açoes simultaneas
sleep(2)

