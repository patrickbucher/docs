#!/usr/bin/env python3

import random
import sys

import numpy as np
from scipy.stats import norm

if len(sys.argv) < 2:
    print(f'usage: {sys.argv[0]} [size]')
    sys.exit(1)

k = int(sys.argv[1])

products = ['Apfel', 'Birne', 'Gurke', 'Orange', 'Melone', 'Karotte',
            'Greyerzer', 'Emmentaler', 'Mozzarella', 'Feta', 'Appenzeller',
            'Salami', 'Schinken', 'Lyoner', 'Mortadella', 'Speck',
            'Cordon-Bleu', 'Bratwurst', 'Puletbrust', 'Cervelat', 'Kutteln',
            'Coca-Cola', 'Fanta', 'Sprite', 'Eistee', 'Himbo', 'Rivella',
            'Milch', 'Joghurt', 'Buttermilch', 'Hüttenkäse', 'Eier', 'Ziger',
            'Erdnüsse', 'Pommes-Chips', 'Salzstangen', 'Pistazien',
            'Mars', 'Snickers', 'Twix', 'Bounty', 'Toffifee', 'Maltesers']

xs = np.linspace(norm.ppf(0.01), norm.ppf(0.99), len(products))
ys = norm.pdf(xs)

choices = random.choices(products, weights=ys, k=k)
for choice in choices:
    print(choice)
