# pan-sharpening

Many technical problems limit the satellite sensors from capturing images with high spatial and high spectral resolutions at the same time. Image fusion techniques used in remote sensing applications with integrates the information from combinations of panchromatic, multispectral or hyperspectral images to have both higher spatial and higher spectral resolutions.

![image](https://github.com/sevvaldurmazbilek/pan-sharpening/assets/59259659/f3d7a090-85df-44be-9c6a-0e2e02d1d8f0)

A. Principal Component Anaylsis (PCA)
Principal component analysis (PCA) is a statistical procedure that uses an orthogonal transformation to convert a set of observations of possibly correlated variables into a set of values of linearly uncorrelated variables called principal components. There may be a high correlation between adjacent bands in a multispectral image and therefore may contain the same or similar spectral information about the objects. The principal component transformation transforms the original dataset into a space of eigenvectors using an ndimensional linear transformation.

When image fusion is performed with PCA, the principal components transformation is applied to the multispectral image. The first major component is obtained, and the contrast is enhanced. The inverse principal components transformation is then performed using the first principal component that is contrast enhancement applied and other principal components. Finally, the resulting image is spectrally improved.

![image](https://github.com/sevvaldurmazbilek/pan-sharpening/assets/59259659/496ab157-f5ba-4d25-8589-8f912cb104e9)

The comparison of PCA (Big Area) and Multispectral Image (Small Area)


B. Brovey Method
The Brovey Method is based on the principle of multiplying the details in the panchromatic image and each multispectral band to the ratio of intensity and the panchromatic image. Since the calculations are directly related to intensity, there may be radiometric distortions in the image depending on the accuracy of the assumption in the intensity calculation. 

![image](https://github.com/sevvaldurmazbilek/pan-sharpening/assets/59259659/35f21795-caf2-4392-b826-a20927701343)

The comparison of Brovey (Big Area) and Multispectral image (Small Area)


C. Gram-Schmidt Method
The Gram-Schmidt pan-sharpening method is very popular among these image fusion methods. It considers all bands of the multispectral image. Therefore, it is more sensitive rather than Brovey or IHS methods. In order to fuse the image, it computes a simulated low-resolution Pan band as a linear combination of the MS bands.

![image](https://github.com/sevvaldurmazbilek/pan-sharpening/assets/59259659/80926bc8-e68b-4a21-8e27-c696828e7e6b)

The comparison of Gram-Schmidt (Big Area) and Multispectral image (Small Area)


D. À Trous Method
The Stationary wavelet transform (SWT) is a wavelet transform algorithm designed to overcome the lack of translation-invariance of the discrete wavelet transform (DWT). Translation-invariance is achieved by removing the down samplers and up samplers in the DWT and upsampling the filter coefficients by a factor of 2(j-1) in the jth level of the algorithm. The SWT is an inherently redundant scheme as the output of each level of SWT contains the same number of samples as the input so for a decomposition of N levels there is a redundancy of N in the wavelet coefficients. This algorithm is more famously known as “algorithme à trous” in French which refers to inserting zeros in the filters.

![image](https://github.com/sevvaldurmazbilek/pan-sharpening/assets/59259659/29b4d171-3551-4af5-ac52-0b2b4934808b)

The comparison of A Trous (Big Area) and Multispectral Image (Small Area)


