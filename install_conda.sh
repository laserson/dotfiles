PACKAGES1="cython numpy scipy pandas scikit-learn jupyter matplotlib biopython scikit-bio spacy"
PACKAGES2="awscli beautifulsoup4 bokeh boto3 click cytoolz DendroPy dill Fabric flake8 googlemaps ipdb jellyfish Jinja2 jinja2-cli luigi pelican seaborn Sphinx thrift google-api-python-client"
curl https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh > miniconda-install.sh
bash miniconda-install.sh -b
export PATH="~/miniconda3/bin:$PATH"
conda update -y conda
conda install -y $PACKAGES1
conda create -y -n py27 python=2.7 $PACKAGES1
conda create -y -n py37 python=3.7 $PACKAGES1
conda info -a
rm miniconda-install.sh
pip install $PACKAGES2
