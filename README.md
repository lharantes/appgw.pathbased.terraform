# Azure Application Gateway path based routing com Terraform

Primeiro, vou dar uma pequena introdução ao que iremos desenvolver aqui e o conceito básico de Azure Application Gateway:

O Azure Application Gateway é um balanceador de carga de tráfego da Web que atua na camada 7 do modelo OSI, que com isso permite que você gerencie o tráfego para seus aplicativos Web. Os balanceadores de carga tradicionais operam na camada de transporte (camada OSI 4 – TCP e UDP).

O Azure Application Gateway pode tomar decisões de destinos com base em outros atributos de uma solicitação HTTP de acordo com o caminho de URI. Por exemplo, você pode encaminhar o tráfego com base na URL de entrada. Portanto, se /imagens estiver na URL de entrada, você poderá encaminhar o tráfego para um backend pool específico de servidores/WebApps configurado para as imagens. Se /video estiver na URL, esse tráfego será encaminhado para outro backend pool otimizado para vídeos. Abaixo uma imagem que nos ajuda a entender melhor.
                
                 
![Alt text](https://arantes.azurewebsites.net/wp-content/uploads/2024/02/appgw-path-based.png "")
