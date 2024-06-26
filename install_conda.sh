PACKAGES_CONDA="cython numpy scipy pandas scikit-learn jupyter matplotlib biopython numba scikit-bio spacy bokeh plotly"
PACKAGES_PIP="awscli beautifulsoup4 bokeh boto3 click cytoolz DendroPy dill Fabric flake8 googlemaps ipdb jellyfish Jinja2 jinja2-cli luigi pelican seaborn Sphinx thrift google-api-python-client black pytest pygments requests seaborn"
curl https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh > miniconda-install.sh
bash miniconda-install.sh -b
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init fish
conda update -y conda
conda install -y $PACKAGES_CONDA
conda info -a
rm miniconda-install.sh
pip install $PACKAGES_PIP
