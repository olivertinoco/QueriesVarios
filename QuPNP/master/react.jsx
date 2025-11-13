// el hijo:
function Input({ label, value, onChange, required, error }) {
  return (
    <div>
      <label>{label}</label>
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className={error ? "border-red-500" : ""}
      />
      {required && error && (
        <span className="text-red-500">Campo requerido</span>
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
