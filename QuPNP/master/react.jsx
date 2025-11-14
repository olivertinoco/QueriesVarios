// el hijo:
USANDO: synthetic Events
========================
(full reactivo los 2 primeros)
se solicita:
- lista de Synthetic Events
- lista de propiedades del DOM accedidas a traves de Synthetic Events


function Input({ label, value, onChange, required, error }) {
  // Estado interno que se sincroniza con el value externo
  const [valor, setValor] = useState(value ?? "");
  // Cada vez que el padre cambia "value", actualizamos el interno
  useEffect(() => {
    setValor(value ?? "");
  }, [value]);

  const numero = Number(valor);
  const entero = Math.trunc(numero);

  const handleChange = (e) => {
    const nuevoValor = e.target.value;
    // 1. Actualiza estado interno (UI inmediata)
    setValor(nuevoValor);
    // 2. Notifica al padre, si lo envía
    onChange?.(nuevoValor);
  };

  return (
    <div>
      <label>{label}</label>
      <input
        value={valor}           // controlado por estado interno
        onChange={handleChange} // puente DOM → estado → padre
        className={error ? "border-red-500" : ""}
      />
      {required && error && (
        <span className="text-red-500">{entero}</span>
      )}
    </div>
  );
}


function Input({ label, value, onChange, required, error }) {
  const numero = Number(value);
  const entero = Math.trunc(numero);

  return (
    <div>
      <label>{label}</label>
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className={error ? "border-red-500" : ""}
      />

      {required && error && (
        <span className="text-red-500">{entero}</span>
      )}
    </div>
  );
}



function Input({ label, value, onChange, required, error }) {
  const [valor, setValor] = useState("4.1");

  const numero = Number(valor);
  const entero = Math.trunc(numero);

  return (
    <div>
      <label>{label}</label>
      <input
        value={value}
        onChange={(e) => setValor(e.target.value)}
        className={error ? "border-red-500" : ""}
      />
      {required && error && (
        <span className="text-red-500">{entero}</span>
      )}
    </div>
  );
}




function Input({ label, value, onChange, required, error }) {
  const [valor, setValor] = useState("4.1");

  const numero = Number(valor);
  const entero = Math.trunc(numero);

  const onChange = (e)=>{
    setValor(e)
  }

  return (
    <div>
      <label>{label}</label>
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className={error ? "border-red-500" : ""}
      />
      {required && error && (
        <span className="text-red-500">{entero}</span>
      )}
    </div>
  );
}





// el padre
function Formulario() {
  const [form, setForm] = useState({ nombre: "", fecha: "" });
  const [errors, setErrors] = useState({});

  const handleChange = (field, value) => {
    setForm({ ...form, [field]: value });
  };

  const validar = () => {
    const errs = {};
    if (!form.nombre) errs.nombre = "El nombre es obligatorio";
    if (!form.fecha) errs.fecha = "La fecha es obligatoria";
    setErrors(errs);
    return Object.keys(errs).length === 0;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (validar()) console.log("Formulario válido:", form);
  };

  return (
    <form onSubmit={handleSubmit}>
      <Input
        label="Nombre"
        value={form.nombre}
        onChange={(v) => handleChange("nombre", v)}
        required
        error={errors.nombre}
      />
      <Input
        label="Fecha"
        value={form.fecha}
        onChange={(v) => handleChange("fecha", v)}
        required
        error={errors.fecha}
      />
      <button type="submit">Guardar</button>
    </form>
  );
}

// =====================================================================================================
//
const [nombre, setNombre] = useState("");

return <input value={nombre} onChange={(e) => setNombre(e.target.value)} />;

// ===========================================

const [formData, setFormData] = useState({});

const handleChange = (campo, valor) => {
  setFormData((prev) => ({
    ...prev,
    [campo]: valor,
  }));
};

<CustomElement
  value={formData[metadata[6]] ?? ""}
  onChange={(valor) => handleChange(metadata[6], valor)}
/>;

// validacion reactiva

const validarCampos = () => {
  const errores = Object.entries(formData).reduce((acc, [campo, valor]) => {
    if (!valor?.trim()) acc[campo] = "Campo obligatorio";
    return acc;
  }, {});
  setErrores(errores);
  return Object.keys(errores).length === 0;
};

zustand

ASIGNAR:
============================================================
const { selectedItems } = useSelectStore.getState();
if (!selectedItems || selectedItems.length === 0) return;
const elementoSeleccionado = selectedItems[0];


ALMACENAR:
============================================================
const { setSelectedItems } = useSelectStore.getState();
setSelectedItems([fila]);


ELIMINAR:
============================================================
useSelectStore.setState({ selectedItems: [] });
