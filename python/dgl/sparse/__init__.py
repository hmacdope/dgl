"""dgl sparse class."""
import glob
import os
import sys

import torch

from .._ffi import libinfo
from .broadcast import *
from .elementwise_op import *
from .elementwise_op_sp import *
from .matmul import *
from .reduction import *  # pylint: disable=W0622
from .sddmm import *
from .softmax import *
from .sparse_matrix import *
from .unary_op import *


def load_dgl_sparse():
    """Load DGL C++ sparse library"""

    if sys.platform.startswith("linux"):
        shared_lib_ext = ".so"
    elif sys.platform.startswith("darwin"):
        shared_lib_ext = ".dylib"
    elif sys.platform.startswith("win"):
        shared_lib_ext = ".dll"
    else:
        raise NotImplementedError("Unsupported system: %s" % sys.platform)

    dirname = os.path.dirname(libinfo.find_lib_path()[0])
    path = os.path.join(dirname, "dgl_sparse", f"*{shared_lib_ext}")
    path = glob.glob(path)
    if len(path) > 1:
        raise ImportError("More than one DGL C++ sparse library found")
    path = path[0]
    if not os.path.exists(path):
        raise FileNotFoundError(f"Cannot find DGL C++ sparse library at {path}")

    try:
        torch.classes.load_library(path)
    except Exception:  # pylint: disable=W0703
        raise ImportError("Cannot load DGL C++ sparse library")


load_dgl_sparse()
